import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/popcap.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/logger.dart';

class Match {
  final Connection connection;
  final DateTime createdAt;
  final Config config;
  final Battlefield battlefield;
  final Players players;
  num elapsedTime = 0;
  MatchStatus status;

  Match._({
    required this.connection,
    required this.createdAt,
    required this.config,
    required this.status,
    required this.battlefield,
    required this.players,
  });

  bool get _isPlaying => status == MatchStatus.playing;

  factory Match.fromJson({
    required Connection connection,
    required JsonMatchStart jsonMatch,
  }) {
    final Players players = Players(Player.list(jsonMatch.players));
    final Config config = Config.fromJson(jsonMatch.config);

    return Match._(
      connection: connection,
      createdAt: DateTime.parse(jsonMatch.createdAt),
      config: config,
      status: MatchStatus.playing,
      battlefield: Battlefield.fromJson(
        json: jsonMatch.battlefield,
        config: config,
        players: players,
      ),
      players: players,
    );
  }

  void start() {
    for (final Player player in players.list) {
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
    if (_isPlaying) {
      if ((type == UnitType.harvester) &&
          battlefield.units.hasMaxHarvesters(playerIndex)) {
        throw Exception('Max harvesters reached');
      }

      final Player player = players.get(playerIndex);
      final int currentAmountOfUnits = battlefield.units.ofPlayer(player);
      final int popcapLimit = Popcap.fromElapsedTime(elapsedTime);

      if (currentAmountOfUnits >= popcapLimit) {
        throw Exception('Popcap limit reached');
      }

      final int cost = battlefield.units.unitCost(
        type: type,
        player: player,
      );

      if (player.removeResources(cost)) {
        final JsonEvent deploymentEvent = battlefield.deployUnit(
          player: player,
          location: location,
          type: type,
        );
        final List<JsonEvent> events = [deploymentEvent];
        events.addAll(
          players.events(battlefield.units).values.map(JsonEvent.player),
        );
        _sendMatchUpdate(events);
      }
    }
  }

  void unitAction({
    required String playerIndex,
    required String unitId,
    required Location? targetLocation,
    required String? targetUnitId,
  }) {
    if (_isPlaying) {
      final Player player = players.get(playerIndex);
      _sendMatchUpdate(
        battlefield.unitAction(
          player: player,
          unitId: unitId,
          targetLocation: targetLocation,
          targetUnitId: targetUnitId,
        ),
      );
    }
  }

  void surrenderMatch(String playerIndex) {
    if (_isPlaying) {
      final Player player = players.get(playerIndex);
      player.surrender();
      Logger.debug('Player $playerIndex surrendered');
      status = MatchStatus.finished;
      _sendMatchUpdate([
        JsonEvent.matchFinished(players.other(player.index).id),
      ]);
    }
  }

  void update(double dt) {
    if (_isPlaying) {
      elapsedTime += dt;

      final Map<String, JsonEventPlayer> previousEvents = players.events(
        battlefield.units,
      );

      final List<JsonEvent> events = battlefield.update(dt);

      for (final Player player in players.list) {
        player.addResources(player.resourcesPassiveRate * dt);
      }

      events.addAll(
        players.newEvents(
          previousEvents: previousEvents,
          newEvents: players.events(battlefield.units),
        ),
      );

      final String? winner = _winner;

      if (winner != null) {
        status = MatchStatus.finished;
        events.add(JsonEvent.matchFinished(winner));
      }

      if (events.isNotEmpty) {
        _sendMatchUpdate(events);
      }
    }
  }

  void _sendMatchUpdate(List<JsonEvent> events) {
    final JsonMatchUpdate jsonMatchUpdate = JsonMatchUpdate(
      status: status,
      events: events,
    );

    connection.broadcast(JsonMessage.update(jsonMatchUpdate));
  }

  String? get _winner {
    final Player player1 = players.get(Constants.PLAYER_1);
    final Player player2 = players.get(Constants.PLAYER_2);

    if (!player2.isAlive && player1.isAlive) {
      Logger.debug('Player 1 wins!');
      return player1.id;
    } else if (!player1.isAlive && player2.isAlive) {
      Logger.debug('Player 2 wins!');
      return player2.id;
    } else {
      return null;
    }
  }

  JsonMatchStart toJson(String selfId) => JsonMatchStart(
    createdAt: createdAt.toIso8601String(),
    config: config.toJson(),
    players: players.list
        .map((player) => player.toJson(selfId == player.id))
        .toList(),
    battlefield: battlefield.toJson(),
  );
}
