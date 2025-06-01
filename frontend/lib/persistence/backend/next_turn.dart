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
        jsonActions: jsonPlayers.values.expand((p) => p.actions).toList(),
      ).values.toList(),
    );
  }

  static Map<String, JsonNode> _nextNodes({
    required Map<String, JsonNode> nodesById,
    required List<JsonAction> jsonActions,
  }) {
    _nextNodesDeployments(nodesById: nodesById, jsonActions: jsonActions);
    _nextNodesMovements(nodesById: nodesById, jsonActions: jsonActions);

    return nodesById;
  }

  static Map<String, JsonNode> _nextNodesDeployments({
    required Map<String, JsonNode> nodesById,
    required List<JsonAction> jsonActions,
  }) {
    for (final JsonAction jsonAction in jsonActions) {
      if (jsonAction.type == ActionType.deploy) {
        final JsonNode targetJsonNode =
            nodesById[jsonAction.targetLocation.id]!;
        nodesById[jsonAction.targetLocation.id] = _nextNodeTargetDeployment(
          jsonNode: targetJsonNode,
          jsonAction: jsonAction,
        );
      }
    }

    return nodesById;
  }

  static Map<String, JsonNode> _nextNodesMovements({
    required Map<String, JsonNode> nodesById,
    required List<JsonAction> jsonActions,
  }) {
    for (final JsonAction jsonAction in jsonActions) {
      if (jsonAction.type == ActionType.move) {
        final JsonNode originJsonNode =
            nodesById[jsonAction.originLocation!.id]!;
        nodesById[jsonAction.originLocation!.id] = _nextNodeOriginMovement(
          jsonNode: originJsonNode,
          jsonAction: jsonAction,
        );

        final JsonNode targetJsonNode =
            nodesById[jsonAction.targetLocation.id]!;
        nodesById[jsonAction.targetLocation.id] = _nextNodeTargetMovement(
          jsonNode: targetJsonNode,
          jsonAction: jsonAction,
        );
      }
    }

    return nodesById;
  }

  static JsonNode _nextNodeTargetDeployment({
    required JsonNode jsonNode,
    required JsonAction jsonAction,
  }) {
    return JsonNode(
      x: jsonNode.x,
      y: jsonNode.y,
      type: jsonNode.type,
      units: JsonUnits(player: jsonAction.playerId, amount: jsonAction.amount!),
      structure: jsonNode.structure,
    );
  }

  static JsonNode _nextNodeOriginMovement({
    required JsonNode jsonNode,
    required JsonAction jsonAction,
  }) {
    return JsonNode(
      x: jsonNode.x,
      y: jsonNode.y,
      type: jsonNode.type,
      units: null,
      structure: jsonNode.structure,
    );
  }

  static JsonNode _nextNodeTargetMovement({
    required JsonNode jsonNode,
    required JsonAction jsonAction,
  }) {
    return JsonNode(
      x: jsonNode.x,
      y: jsonNode.y,
      type: jsonNode.type,
      units: (jsonNode.units != null)
          ? JsonUnits(
              player: jsonAction.playerId,
              amount: jsonNode.units!.amount + jsonAction.amount!,
            )
          : JsonUnits(player: jsonAction.playerId, amount: jsonAction.amount!),
      structure: jsonNode.structure,
    );
  }
}
