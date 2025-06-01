import 'dart:async';

import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/actions.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/turn.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_structure.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/json/json_units.dart';
import 'package:tensionpath/extensions/size_extension.dart';
import 'package:tensionpath/persistence/backend/end_turn_opponent.dart';
import 'package:tensionpath/persistence/backend/end_turn_self.dart';
import 'package:tensionpath/persistence/backend/start_matchmaking.dart';
import 'package:tensionpath/persistence/backend/stop_matchmaking.dart';

class Backend {
  /*static final StreamListener _matchListener = StreamListener();

  static void start(String matchId) {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('matches')
        .doc(matchId);

    _matchListener.start(
      reference.snapshots().listen((snapshot) {
        if (snapshot.exists) {
          final JsonMatch jsonMatch = JsonMatch.fromJson(snapshot.json);
          _onUpdated(jsonMatch);
        }
      }, onError: ErrorHandler.process),
    );
  }

  static void stop() => _matchListener.stop();

  static Future _onUpdated(JsonMatch jsonMatch) async {
    final bool allWaiting = jsonMatch.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      final JsonMatch jsonMatchUpdated = NextTurn()(jsonMatch);
      await MatchRepository.update(jsonMatchUpdated);
    }
  }*/

  // =============================== END POINTS ================================

  static Future<String> startMatchmaking({
    required String userId,
    required String playerName,
  }) => StartMatchmaking()(userId: userId, playerName: playerName);

  static Future stopMatchmaking({
    required String userId,
    required String roomId,
  }) => StopMatchmaking()(userId: userId, roomId: roomId);

  static Future endTurnSelf({required Match match, required String selfId}) =>
      EndTurnSelf()(jsonMatch: _jsonMatch(match), selfId: selfId);

  static Future endTurnOpponent({
    required Match match,
    required String selfId,
  }) => EndTurnOpponent()(jsonMatch: _jsonMatch(match), selfId: selfId);

  // ================================= UTILS ===================================

  static JsonMatch _jsonMatch(Match match) => JsonMatch(
    id: match.id,
    version: match.version,
    createdAt: match.createdAt,
    config: _configToJson(match.config),
    turn: _turnToJson(match.turn),
    players: _playersToJson(match),
    battlefield: _battlefieldToJson(match.battlefield),
  );

  static JsonConfig _configToJson(Config config) => JsonConfig(
    popcap: config.popcap,
    baseMaxHealth: config.baseMaxHealth,
    resourcesPerPatch: config.resourcesPerPatch,
    resourcesPerTurn: config.resourcesPerTurn,
    resourcesPerSecond: config.resourcesPerSecond,
  );

  static JsonTurn _turnToJson(Turn turn) =>
      JsonTurn(turn: turn.turn, startedAt: turn.startedAt);

  static Map<String, JsonPlayer> _playersToJson(Match match) => {
    match.self.id: _playerToJson(match.self),
    match.opponent.id: _playerToJson(match.opponent),
  };

  static JsonPlayer _playerToJson(Player player) => JsonPlayer(
    name: player.name,
    baseHealth: player.baseHealth,
    resources: player.resources,
    status: player.status,
    turnEndedAt: player.turnEndedAt,
    actions: _actionsToJson(player.actions),
  );

  static List<JsonAction> _actionsToJson(Actions actions) {
    final List<JsonAction> result = [];

    for (final Action action in actions) {
      result.add(JsonAction.fromAction(action));
    }

    return result;
  }

  static JsonNode _nodeToJson(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    units: _unitsToJson(node.units),
    structure: _structureToJson(node.structure),
  );

  static JsonBattlefield _battlefieldToJson(Battlefield battlefield) =>
      JsonBattlefield(
        id: battlefield.id,
        size: battlefield.size.toJsonSize(),
        missile: _missileToJson(battlefield.missile),
        nodes: battlefield.nodes.map(_nodeToJson).toList(),
      );

  static JsonMissile _missileToJson(Missile missile) => JsonMissile(
    charge: missile.charge,
    maxCharge: missile.maxCharge,
    platforms: missile.numberOfPlatforms,
  );

  static JsonUnits? _unitsToJson(Units? units) {
    if (units != null) {
      return JsonUnits(player: units.player.id, amount: units.amount);
    } else {
      return null;
    }
  }

  static JsonStructure? _structureToJson(Structure? structure) {
    if (structure != null) {
      return JsonStructure(
        type: structure.type,
        player: structure.getPlayerId,
        platformId: structure.getPlatformId,
      );
    } else {
      return null;
    }
  }
}
