import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_structure.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/json/json_units.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/extensions/size_extension.dart';
import 'package:tensionpath/persistence/backend/end_turn.dart';
import 'package:tensionpath/persistence/backend/end_turn_opponent.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';
import 'package:tensionpath/persistence/backend/start_matchmaking.dart';
import 'package:tensionpath/persistence/backend/stop_matchmaking.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/utils/error_handler.dart';
import 'package:tensionpath/utils/stream_listener.dart';

class Backend {
  static final StreamListener _matchListener = StreamListener();

  static void start(String matchId) => _matchListener.start(_listen(matchId));

  static void stop() => _matchListener.stop();

  static StreamSubscription _listen(String matchId) {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('matches')
        .doc(matchId);
    return reference.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final JsonMatch json = JsonMatch.fromJson(snapshot.json);
        _onUpdated(json);
      }
    }, onError: ErrorHandler.process);
  }

  static Future _onUpdated(JsonMatch json) async {
    final bool allWaiting = json.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      await MatchRepository.update(JsonUtils.nexTurn(json));
    }
  }

  // =============================== END POINTS ================================

  static Future<String> startMatchmaking({
    required String userId,
    required String playerName,
  }) => StartMatchmaking().call(userId: userId, playerName: playerName);

  static Future stopMatchmaking({
    required String userId,
    required String roomId,
  }) => StopMatchmaking().call(userId: userId, roomId: roomId);

  static Future endTurnSelf({required Match match, required String selfId}) =>
      EndTurn().call(jsonMatch: _jsonMatch(match), selfId: selfId);

  static Future endTurnOpponent({
    required Match match,
    required String selfId,
  }) => EndTurnOpponent().call(jsonMatch: _jsonMatch(match), selfId: selfId);

  static JsonMatch _jsonMatch(Match match) => JsonMatch(
    id: match.id,
    version: match.version,
    createdAt: match.createdAt,
    config: JsonConfig(
      popcap: match.config.popcap,
      baseMaxHealth: match.config.baseMaxHealth,
      resourcesPerPatch: match.config.resourcesPerPatch,
      resourcesPerTurn: match.config.resourcesPerTurn,
      resourcesPerSecond: match.config.resourcesPerSecond,
    ),
    turn: JsonTurn(turn: match.turn.turn, startedAt: match.turn.startedAt),
    players: {
      match.self.id: _playerToJson(match.self),
      match.opponent.id: _playerToJson(match.opponent),
    },
    battlefield: JsonBattlefield(
      id: match.battlefield.id,
      size: match.battlefield.size.toJsonSize(),
      missile: JsonMissile(
        charge: match.battlefield.missile.charge,
        maxCharge: match.battlefield.missile.maxCharge,
        platforms: match.battlefield.missile.numberOfPlatforms,
      ),
      nodes: match.battlefield.nodes.map(_nodeToJson).toList(),
    ),
  );

  static JsonPlayer _playerToJson(Player player) => JsonPlayer(
    name: player.name,
    baseHealth: player.baseHealth,
    resources: player.resources,
    status: player.status,
    turnEndedAt: player.turnEndedAt,
  );

  static JsonNode _nodeToJson(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: _unitsToJson(node.units),
    structure: _structureToJson(node.structure),
  );

  static JsonUnits? _unitsToJson(Units? units) {
    if (units != null) {
      return JsonUnits(
        player: units.player.id,
        amount: units.amount,
        moveToX: units.moveTo?.x,
        moveToY: units.moveTo?.y,
      );
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
