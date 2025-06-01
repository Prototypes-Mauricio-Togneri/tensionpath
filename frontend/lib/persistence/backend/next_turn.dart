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
    return JsonBattlefield(
      id: jsonBattlefield.id,
      size: jsonBattlefield.size,
      missile: jsonBattlefield.missile,
      nodes: _nextNodes(
        jsonNodes: jsonBattlefield.nodes,
        jsonActions: jsonPlayers.values.expand((p) => p.actions).toList(),
      ),
    );
  }

  static List<JsonNode> _nextNodes({
    required List<JsonNode> jsonNodes,
    required List<JsonAction> jsonActions,
  }) {
    final List<JsonNode> withDeployments = _nextNodesDeployments(
      jsonNodes: jsonNodes,
      jsonActions: jsonActions,
    );

    return withDeployments;
  }

  static List<JsonNode> _nextNodesDeployments({
    required List<JsonNode> jsonNodes,
    required List<JsonAction> jsonActions,
  }) {
    final List<JsonNode> result = [];

    for (final JsonNode jsonNode in jsonNodes) {
      result.add(
        _nextNodeDeployments(jsonNode: jsonNode, jsonActions: jsonActions),
      );
    }

    return result;
  }

  static JsonNode _nextNodeDeployments({
    required JsonNode jsonNode,
    required List<JsonAction> jsonActions,
  }) {
    for (final JsonAction jsonAction in jsonActions) {
      if (jsonAction.type == ActionType.deploy &&
          jsonAction.targetLocation == jsonNode.location) {
        return _nextNodeTargetDeploy(
          jsonNode: jsonNode,
          jsonAction: jsonAction,
        );
      }
    }

    return jsonNode;
  }

  static JsonNode _nextNodeTargetDeploy({
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
}
