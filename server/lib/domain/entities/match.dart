import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Match {
  final Connection connection;
  final DateTime createdAt;
  final Battlefield battlefield;
  final IterableMap<String, Player> players;
  double totalTime = 0;
  MatchStatus status;

  Match._({
    required this.connection,
    required this.createdAt,
    required this.status,
    required this.battlefield,
    required this.players,
  });

  factory Match.fromJson({
    required Connection connection,
    required JsonMatchStart jsonMatch,
  }) => Match._(
    connection: connection,
    createdAt: DateTime.parse(jsonMatch.createdAt),
    status: MatchStatus.playing,
    battlefield: Battlefield.fromJson(jsonMatch.battlefield),
    players: Player.list(jsonMatch.players),
  );

  void start() {
    for (final Player player in players) {
      connection.direct(
        playerIndex: player.index,
        json: JsonMessage.start(toJson(player.id)),
      );
    }
  }

  void deployUnit({
    required String playerIndex,
    required Location location,
    required UnitType type,
  }) {
    final Player player = players.get(playerIndex);

    if (player.resources >= type.cost) {
      player.removeResources(type.cost.toDouble());
      battlefield.deployUnit(
        player: player,
        location: location,
        type: type,
      );
      _sendMatchUpdate();
    }
  }

  void update(double dt) {
    if (status == MatchStatus.playing) {
      totalTime += dt;

      for (final Player player in players) {
        player.resourcesRate = player.resourcesRateBase;
      }

      final bool sendUpdate = battlefield.update(dt);

      for (final Player player in players) {
        player.resources += player.resourcesRate * dt;
      }

      if (sendUpdate) {
        _sendMatchUpdate();
      }
    }
  }

  void _sendMatchUpdate() {
    final Map<String, JsonPlayerUpdate> playersUpdate = {
      for (final Player player in players) player.index: player.toJsonUpdate(),
    };

    final JsonMatchUpdate jsonMatchUpdate = JsonMatchUpdate(
      players: playersUpdate,
      missile: battlefield.missile.toJsonUpdate(),
      resources: battlefield.resourcesToJsonUpdate(),
      units: battlefield.unitsToJsonUpdate(),
    );

    connection.broadcast(JsonMessage.update(jsonMatchUpdate));
  }

  JsonMatchStart toJson(String selfId) => JsonMatchStart(
    createdAt: createdAt.toIso8601String(),
    players: players.list
        .map((player) => player.toJson(selfId == player.id))
        .toList(),
    battlefield: battlefield.toJsonStart(),
  );
}
