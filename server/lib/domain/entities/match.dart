import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/popcap.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/logger.dart';
import 'package:tensionpath/utils/trace.dart';

class Match {
  final Connection connection;
  final DateTime createdAt;
  final Config config;
  final Battlefield battlefield;
  final Players players;
  final Trace updateTrace = Trace(name: 'match_update');
  num elapsedTime = 0;
  num matchOverTimeout = 0;
  MatchStatus status;
  JsonEvent? matchFinishedEvent;

  Match._({
    required this.connection,
    required this.createdAt,
    required this.config,
    required this.status,
    required this.battlefield,
    required this.players,
  });

  bool get _isPlaying => status == MatchStatus.playing;

  bool get _isOver => status == MatchStatus.over;

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

  void unlockBuilding({
    required String playerIndex,
    required BuildingType type,
  }) {
    final Player player = players.get(playerIndex);

    if (!player.hasBuildingLocked(type)) {
      throw Exception('Building has been already unlocked');
    }

    if (player.removeResources(type.cost)) {
      final List<JsonEvent> events = [
        player.unlockBuilding(type),
      ];
      events.addAll(players.events(battlefield.units));
      _sendMatchUpdate(events);
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

      if (player.hasBuildingLocked(type.buildingType)) {
        throw Exception('Building for unit $type is locked');
      }

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
        events.addAll(players.events(battlefield.units));
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
      final List<JsonEvent> events = battlefield.unitAction(
        player: player,
        unitId: unitId,
        targetLocation: targetLocation,
        targetUnitId: targetUnitId,
      );
      events.addAll(players.events(battlefield.units));
      _sendMatchUpdate(events);
    }
  }

  void surrenderMatch(String playerIndex) {
    if (_isPlaying) {
      final Player player = players.get(playerIndex);
      player.surrender();
      Logger.debug('Player $playerIndex surrendered');
      _onMatchOver(
        JsonEvent.matchFinished(
          winner: players.other(player.index).id,
          loser: player.id,
        ),
      );
    }
  }

  void update(double dt) {
    if (_isPlaying) {
      updateTrace.start();
      elapsedTime += dt;

      // Check for timeout
      if (elapsedTime >= config.matchTimeout) {
        Logger.debug('Match timed out');
        final Player? winner = _playerAhead;

        if (winner != null) {
          _onMatchOver(
            JsonEvent.matchFinished(
              winner: winner.id,
              loser: players.other(winner.index).id,
            ),
          );
        } else {
          _onMatchOver(
            JsonEvent.matchFinished(
              winner: null,
              loser: null,
            ),
          );
        }
      }

      // Update battlefield
      final (List<JsonEvent>, bool) battlefieldUpdate = battlefield.update(dt);
      final List<JsonEvent> events = battlefieldUpdate.$1;
      bool sendPlayerUpdates = battlefieldUpdate.$2;

      // Check for sudden death
      if (elapsedTime >= config.suddenDeathTimeout) {
        sendPlayerUpdates = true;

        for (final Player player in players.list) {
          final num damage = config.suddenDeathDamage * dt;
          player.removeHealth(damage);
          events.add(
            JsonEvent.baseDamaged(
              playerIndex: player.index,
              damage: damage,
            ),
          );
        }
      }

      // Add resources to players
      for (final Player player in players.list) {
        player.addResources(player.resourcesPassiveRate * dt);
      }

      // Add player updates
      if (sendPlayerUpdates) {
        events.addAll(players.events(battlefield.units));
      }

      // Check for winner
      final Player? winner = _winner;

      if (winner != null) {
        _onMatchOver(
          JsonEvent.matchFinished(
            winner: winner.id,
            loser: players.other(winner.index).id,
          ),
        );
      }

      // Send updates if there are any events
      if (events.isNotEmpty) {
        _sendMatchUpdate(events);
      }

      updateTrace.stop();
    } else if (_isOver) {
      matchOverTimeout += dt;

      if (matchOverTimeout >= Constants.MATCH_OVER_TIMEOUT) {
        status = MatchStatus.finished;

        if (matchFinishedEvent != null) {
          _sendMatchUpdate([matchFinishedEvent!]);
        }
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

  void _onMatchOver(JsonEvent event) {
    status = MatchStatus.over;
    matchFinishedEvent = event;
    Logger.info(updateTrace.toString());
  }

  Player? get _winner {
    final Player player1 = players.get(Constants.PLAYER_1);
    final Player player2 = players.get(Constants.PLAYER_2);

    if (!player2.isAlive && player1.isAlive) {
      Logger.debug('Player 1 wins!');
      return player1;
    } else if (!player1.isAlive && player2.isAlive) {
      Logger.debug('Player 2 wins!');
      return player2;
    } else {
      return null;
    }
  }

  Player? get _playerAhead {
    final Player player1 = players.get(Constants.PLAYER_1);
    final Player player2 = players.get(Constants.PLAYER_2);

    if (player1.baseHealth > player2.baseHealth) {
      Logger.debug('Player 1 is ahead!');
      return player1;
    } else if (player2.baseHealth > player1.baseHealth) {
      Logger.debug('Player 2 is ahead!');
      return player2;
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
