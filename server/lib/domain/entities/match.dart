import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/popcap.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
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
      battlefield.deployUnit(
        player: player,
        location: location,
        type: type,
      );
      _sendMatchUpdate();
    }
  }

  void unitAction({
    required String playerIndex,
    required String unitId,
    required Location? targetLocation,
    required String? targetUnitId,
  }) {
    final Player player = players.get(playerIndex);
    battlefield.unitAction(
      player: player,
      unitId: unitId,
      targetLocation: targetLocation,
      targetUnitId: targetUnitId,
    );
    _sendMatchUpdate();
  }

  void surrenderMatch(String playerIndex) {
    final Player player = players.get(playerIndex);
    player.surrender();
    status = MatchStatus.finished;
    Logger.debug('Player ${player.index} surrendered');
    _sendMatchUpdate();
  }

  void update(double dt) {
    elapsedTime += dt;

    if (status == MatchStatus.playing) {
      bool sendUpdate = battlefield.update(dt);

      if (battlefield.missile.isFullyCharged) {
        _fireMissile();
        sendUpdate = true;
      }

      for (final Player player in players.list) {
        player.addResources(player.resourcesPassiveRate * dt);
      }

      if (sendUpdate) {
        _sendMatchUpdate();
      }
    }
  }

  void _fireMissile() {
    for (final Player player in players.list) {
      if (player.index != battlefield.missile.owner) {
        player.removeHealth(player.baseMaxHealth * battlefield.missile.damage);
        Logger.debug('Missile launched to ${player.index}');
        break;
      }
    }

    battlefield.missile.resetCharge();
  }

  void _sendMatchUpdate() {
    final String? winner = _winner;

    if (winner != null) {
      status = MatchStatus.finished;
    } else {
      battlefield.updateMissile();
    }

    final JsonMatchUpdate jsonMatchUpdate = JsonMatchUpdate(
      status: status,
      players: _getPlayersUpdate(),
      missile: battlefield.missile.toJsonUpdate(),
      resources: battlefield.resourcesToJsonUpdate(),
      units: battlefield.unitsToJsonUpdate(),
      events: [],
      winner: winner,
    );

    connection.broadcast(JsonMessage.update(jsonMatchUpdate));
  }

  Map<String, JsonPlayerUpdate> _getPlayersUpdate() {
    final Units units = battlefield.units;
    final Map<String, JsonPlayerUpdate> result = {};

    for (final Player player in players.list) {
      result[player.index] = player.toJsonUpdate(
        currentHarvesterCount: units.currentHarvesterCount(player.index),
        maxHarvesterCount: units.maxHarvesterCount(player.index),
        resourcesExtraRate:
            units.currentHarvestersWorking(player.index) *
            player.resourcesActiveRate,
      );
    }

    return result;
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
    battlefield: battlefield.toJsonStart(),
  );
}
