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
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/iterable_map.dart';
import 'package:tensionpath/utils/logger.dart';

class Match {
  final Connection connection;
  final DateTime createdAt;
  final Battlefield battlefield;
  final IterableMap<String, Player> players;
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

    if (player.removeResources(type.cost)) {
      battlefield.deployUnit(
        player: player,
        location: location,
        type: type,
      );
      _sendMatchUpdate();
    }
  }

  void moveUnit({
    required String playerIndex,
    required String unitId,
    required Location location,
  }) {
    final Player player = players.get(playerIndex);
    battlefield.moveUnit(
      player: player,
      unitId: unitId,
      location: location,
    );
    _sendMatchUpdate();
  }

  void attackUnit({
    required String playerIndex,
    required String attackerUnitId,
    required String defenderUnitId,
  }) {
    final Player player = players.get(playerIndex);
    battlefield.attackUnit(
      player: player,
      attackerUnitId: attackerUnitId,
      defenderUnitId: defenderUnitId,
    );
    _sendMatchUpdate();
  }

  void update(double dt) {
    if (status == MatchStatus.playing) {
      bool sendUpdate = battlefield.update(dt);

      if (battlefield.missile.isFullyCharged) {
        _fireMissile();
        sendUpdate = true;
      }

      for (final Player player in players) {
        player.addResources(player.resourcesRate * dt);
      }

      if (sendUpdate) {
        _sendMatchUpdate();
      }
    }
  }

  void _fireMissile() {
    for (final Player player in players) {
      if (player.index != battlefield.missile.owner) {
        player.removeHealth(player.baseMaxHealth / 2);
        Logger.info('Missile launched to ${player.index}');
        break;
      }
    }

    battlefield.missile.resetCharge();
  }

  void _sendMatchUpdate() {
    final String? winner = _winner;

    if (winner != null) {
      status = MatchStatus.finished;
      connection.broadcast(JsonMessage.finish(winner));
      return;
    }

    battlefield.updateMissile();

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

  String? get _winner {
    final Player player1 = players.get(Constants.PLAYER_1);
    final Player player2 = players.get(Constants.PLAYER_2);

    if (!player2.isAlive && player1.isAlive) {
      Logger.info('Player 1 wins!');
      return player1.id;
    } else if (!player1.isAlive && player2.isAlive) {
      Logger.info('Player 2 wins!');
      return player2.id;
    } else {
      return null;
    }
  }

  JsonMatchStart toJson(String selfId) => JsonMatchStart(
    createdAt: createdAt.toIso8601String(),
    players: players.list
        .map((player) => player.toJson(selfId == player.id))
        .toList(),
    battlefield: battlefield.toJsonStart(),
  );
}
