import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/json/json_units.dart';
import 'package:tensionpath/domain/types/action_type.dart';
import 'package:tensionpath/domain/types/player_status.dart';

class NextTurn {
  Future<JsonMatch> call(JsonMatch jsonMatch) async {
    final bool allWaiting = jsonMatch.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      return JsonMatch(
        id: jsonMatch.id,
        version: jsonMatch.version,
        createdAt: jsonMatch.createdAt,
        config: jsonMatch.config,
        turn: _nextTurn(jsonMatch.turn),
        players: _nextPlayers(jsonMatch.players),
        battlefield: _nextBattlefield(
          jsonBattlefield: jsonMatch.battlefield,
          jsonPlayers: jsonMatch.players,
        ),
      );
    } else {
      return jsonMatch;
    }
  }

  static JsonTurn _nextTurn(JsonTurn jsonTurn) =>
      JsonTurn(turn: jsonTurn.turn + 1, startedAt: DateTime.now());

  static Map<String, JsonPlayer> _nextPlayers(
    Map<String, JsonPlayer> jsonPlayers,
  ) => Map.fromEntries(
    jsonPlayers.entries.map(
      (entry) => MapEntry(entry.key, _nextPlayer(entry.value)),
    ),
  );

  static JsonPlayer _nextPlayer(JsonPlayer jsonPlayer) => JsonPlayer(
    name: jsonPlayer.name,
    baseHealth: jsonPlayer.baseHealth,
    resources: jsonPlayer.resources,
    status: PlayerStatus.playing,
    turnEndedAt: null,
    actions: [],
  );

  static JsonBattlefield _nextBattlefield({
    required JsonBattlefield jsonBattlefield,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    final Map<String, JsonNode> nodesById = Map.fromEntries(
      jsonBattlefield.nodes.map((node) => MapEntry(node.location.id, node)),
    );

    return JsonBattlefield(
      id: jsonBattlefield.id,
      size: jsonBattlefield.size,
      missile: jsonBattlefield.missile,
      nodes: _nextNodes(
        nodesById: nodesById,
        actions: jsonPlayers.values
            .expand((p) => p.actions)
            .map(MuttableAction.fromJson)
            .toList(),
      ).values.toList(),
    );
  }

  static Map<String, JsonNode> _nextNodes({
    required Map<String, JsonNode> nodesById,
    required List<MuttableAction> actions,
  }) {
    _nextNodesDeployments(
      nodesById: nodesById,
      actions: actions.where((a) => a.type == ActionType.deploy).toList(),
    );
    _nextNodesMovements(
      nodesById: nodesById,
      actions: actions.where((a) => a.type == ActionType.move).toList(),
    );

    return nodesById;
  }

  static Map<String, JsonNode> _nextNodesDeployments({
    required Map<String, JsonNode> nodesById,
    required List<MuttableAction> actions,
  }) {
    for (final MuttableAction action in actions) {
      final JsonNode targetJsonNode = nodesById[action.targetLocation.id]!;
      nodesById[action.targetLocation.id] = _nextNodeTargetDeployment(
        jsonNode: targetJsonNode,
        action: action,
      );
    }

    return nodesById;
  }

  static Map<String, JsonNode> _nextNodesMovements({
    required Map<String, JsonNode> nodesById,
    required List<MuttableAction> actions,
  }) {
    for (final MuttableAction action in actions) {
      final JsonNode originJsonNode = nodesById[action.originLocation.id]!;
      final JsonNode targetJsonNode = nodesById[action.targetLocation.id]!;

      nodesById[action.targetLocation.id] = _nextNodeTargetMovement(
        originJsonNode: originJsonNode,
        targetJsonNode: targetJsonNode,
        action: action,
      );
      nodesById[action.originLocation.id] = _nextNodeOriginMovement(
        originJsonNode,
      );
    }

    return nodesById;
  }

  static JsonNode _nextNodeTargetDeployment({
    required JsonNode jsonNode,
    required MuttableAction action,
  }) {
    return JsonNode(
      x: jsonNode.x,
      y: jsonNode.y,
      type: jsonNode.type,
      units: JsonUnits(player: action.playerId, amount: action.amount),
      structure: jsonNode.structure,
    );
  }

  static JsonNode _nextNodeOriginMovement(JsonNode jsonNode) {
    return JsonNode(
      x: jsonNode.x,
      y: jsonNode.y,
      type: jsonNode.type,
      units: null,
      structure: jsonNode.structure,
    );
  }

  static JsonNode _nextNodeTargetMovement({
    required JsonNode originJsonNode,
    required JsonNode targetJsonNode,
    required MuttableAction action,
  }) {
    final int unitsInSource = originJsonNode.units!.amount;
    final int unitsInTarget = targetJsonNode.units?.amount ?? 0;

    return JsonNode(
      x: targetJsonNode.x,
      y: targetJsonNode.y,
      type: targetJsonNode.type,
      units: JsonUnits(
        player: action.playerId,
        amount: unitsInSource + unitsInTarget,
      ),
      structure: targetJsonNode.structure,
    );
  }
}

class MuttableAction {
  ActionType type;
  String playerId;
  int originX;
  int originY;
  int targetX;
  int targetY;
  int amount;

  MuttableAction({
    required this.type,
    required this.playerId,
    required this.originX,
    required this.originY,
    required this.targetX,
    required this.targetY,
    required this.amount,
  });

  Location get originLocation => Location(x: originX, y: originY);

  Location get targetLocation => Location(x: targetX, y: targetY);

  factory MuttableAction.fromJson(JsonAction json) {
    return MuttableAction(
      type: json.type,
      playerId: json.playerId,
      originX: json.originX ?? 0,
      originY: json.originY ?? 0,
      targetX: json.targetX,
      targetY: json.targetY,
      amount: json.amount ?? 0,
    );
  }
}
