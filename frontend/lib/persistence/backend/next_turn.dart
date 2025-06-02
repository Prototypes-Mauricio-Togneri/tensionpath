import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_structure.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/json/json_units.dart';
import 'package:tensionpath/domain/types/action_type.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class NextTurn {
  Future<JsonMatch> call(JsonMatch jsonMatch) async {
    final bool allWaiting = jsonMatch.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      final JsonBattlefield jsonBattlefield = _nextBattlefield(
        jsonBattlefield: jsonMatch.battlefield,
        jsonPlayers: jsonMatch.players,
      );

      return JsonMatch(
        id: jsonMatch.id,
        version: jsonMatch.version,
        createdAt: jsonMatch.createdAt,
        config: jsonMatch.config,
        turn: _nextTurn(jsonMatch.turn),
        players: _nextPlayers(
          jsonPlayers: jsonMatch.players,
          jsonBattlefield: jsonBattlefield,
        ),
        battlefield: jsonBattlefield,
      );
    } else {
      return jsonMatch;
    }
  }

  static JsonTurn _nextTurn(JsonTurn jsonTurn) =>
      JsonTurn(turn: jsonTurn.turn + 1, startedAt: DateTime.now());

  static Map<String, JsonPlayer> _nextPlayers({
    required Map<String, JsonPlayer> jsonPlayers,
    required JsonBattlefield jsonBattlefield,
  }) {
    final DateTime player1TurnEndedAt =
        jsonPlayers[Constants.PLAYER_1]!.turnEndedAt!;
    final DateTime player2TurnEndedAt =
        jsonPlayers[Constants.PLAYER_2]!.turnEndedAt!;

    final Map<String, int> extraResources = {
      Constants.PLAYER_1: 0,
      Constants.PLAYER_2: 0,
    };

    if (player1TurnEndedAt.isAfter(player2TurnEndedAt)) {
      final int diffSeconds = player1TurnEndedAt
          .difference(player2TurnEndedAt)
          .inSeconds;
      extraResources[Constants.PLAYER_2] =
          diffSeconds * Constants.RESOURCES_PER_SECOND;
    } else if (player2TurnEndedAt.isAfter(player1TurnEndedAt)) {
      final int diffSeconds = player2TurnEndedAt
          .difference(player1TurnEndedAt)
          .inSeconds;
      extraResources[Constants.PLAYER_1] =
          diffSeconds * Constants.RESOURCES_PER_SECOND;
    }

    for (final JsonNode jsonNode in jsonBattlefield.nodes) {
      if ((jsonNode.structure != null) &&
          (jsonNode.structure!.type == StructureType.resources) &&
          (jsonNode.units != null)) {
        extraResources[jsonNode.units!.player] = jsonNode.units!.amount;
      }
    }

    return Map.fromEntries(
      jsonPlayers.entries.map(
        (entry) => MapEntry(
          entry.key,
          _nextPlayer(
            jsonPlayer: entry.value,
            extraResources: extraResources[entry.key]!,
          ),
        ),
      ),
    );
  }

  static JsonPlayer _nextPlayer({
    required JsonPlayer jsonPlayer,
    required int extraResources,
  }) => JsonPlayer(
    name: jsonPlayer.name,
    baseHealth: jsonPlayer.baseHealth,
    resources:
        jsonPlayer.resources + Constants.RESOURCES_PER_TURN + extraResources,
    status: PlayerStatus.playing,
    turnEndedAt: null,
    actions: [],
  );

  static JsonBattlefield _nextBattlefield({
    required JsonBattlefield jsonBattlefield,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    final Map<String, MuttableNode> nodesById = Map.fromEntries(
      jsonBattlefield.nodes.map(
        (node) => MapEntry(node.location.id, MuttableNode.fromJson(node)),
      ),
    );

    return JsonBattlefield(
      id: jsonBattlefield.id,
      size: jsonBattlefield.size,
      missile: jsonBattlefield.missile,
      nodes: _nextNodes(nodesById: nodesById, jsonPlayers: jsonPlayers),
    );
  }

  static List<JsonNode> _nextNodes({
    required Map<String, MuttableNode> nodesById,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    final List<MuttableAction> actions = jsonPlayers.values
        .expand((p) => p.actions)
        .map(MuttableAction.fromJson)
        .toList();

    _nextNodesDeployments(
      nodesById: nodesById,
      actions: actions.where((a) => a.type == ActionType.deploy).toList(),
    );
    _nextNodesMovements(
      nodesById: nodesById,
      actions: actions.where((a) => a.type == ActionType.move).toList(),
      jsonPlayers: jsonPlayers,
    );

    return nodesById.values.map((node) => node.toJson()).toList();
  }

  static Map<String, MuttableNode> _nextNodesDeployments({
    required Map<String, MuttableNode> nodesById,
    required List<MuttableAction> actions,
  }) {
    for (final MuttableAction action in actions) {
      _nextNodeDeployment(
        node: nodesById[action.targetLocation.id]!,
        action: action,
      );
    }

    return nodesById;
  }

  static Map<String, MuttableNode> _nextNodesMovements({
    required Map<String, MuttableNode> nodesById,
    required List<MuttableAction> actions,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    for (final MuttableAction action in actions) {
      _nextNodesMovement(
        originNode: nodesById[action.originLocation.id]!,
        targetNode: nodesById[action.targetLocation.id]!,
        action: action,
        jsonPlayers: jsonPlayers,
      );
    }

    return nodesById;
  }

  static void _nextNodeDeployment({
    required MuttableNode node,
    required MuttableAction action,
  }) {
    node.units = MuttableUnits(player: action.playerId, amount: action.amount);
  }

  static void _nextNodesMovement({
    required MuttableNode originNode,
    required MuttableNode targetNode,
    required MuttableAction action,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    final MuttableUnits sourceUnits = originNode.units!;
    final MuttableUnits? targetUnits = targetNode.units;

    if (targetUnits == null) {
      // Target node is empty
      targetNode.units = MuttableUnits(
        player: action.playerId,
        amount: sourceUnits.amount,
      );
    } else {
      if (sourceUnits.player == targetUnits.player) {
        // Same player's unit in source and target
        targetUnits.amount += sourceUnits.amount;
      } else {
        // Battle between players units
        if (sourceUnits.amount > targetUnits.amount) {
          // Source node has more units
          targetUnits.amount = sourceUnits.amount - targetUnits.amount;
          targetUnits.player = sourceUnits.player;
        } else if (sourceUnits.amount < targetUnits.amount) {
          // Target node has more units
          targetUnits.amount = targetUnits.amount - sourceUnits.amount;
          targetUnits.player = targetUnits.player;
        } else {
          // All units are destroyed
          originNode.units = null;
          targetNode.units = null;
        }
      }
    }

    originNode.units = null;

    final MuttableStructure? targetNodeStructure = targetNode.structure;

    if (targetNodeStructure != null &&
        targetNodeStructure.type == StructureType.launcher) {
      final MuttableUnits targetUnitsAfterBattle = targetNode.units!;

      if (targetUnitsAfterBattle.player != targetNodeStructure.player) {
        // Attack player's base
        final JsonPlayer player = jsonPlayers[targetNodeStructure.player!]!;
        jsonPlayers[targetNodeStructure.player!] = JsonPlayer(
          name: player.name,
          baseHealth: player.baseHealth - targetUnitsAfterBattle.amount,
          resources: player.resources,
          status: player.status,
          turnEndedAt: player.turnEndedAt,
          actions: player.actions,
        );

        targetNode.units = null;
      }
    }
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

  factory MuttableAction.fromJson(JsonAction json) => MuttableAction(
    type: json.type,
    playerId: json.playerId,
    originX: json.originX ?? 0,
    originY: json.originY ?? 0,
    targetX: json.targetX,
    targetY: json.targetY,
    amount: json.amount ?? 0,
  );
}

class MuttableNode {
  String id;
  int x;
  int y;
  NodeType type;
  MuttableUnits? units;
  MuttableStructure? structure;

  MuttableNode({
    required this.id,
    required this.x,
    required this.y,
    required this.type,
    this.units,
    this.structure,
  });

  factory MuttableNode.fromJson(JsonNode json) => MuttableNode(
    id: json.location.id,
    x: json.x,
    y: json.y,
    type: json.type,
    units: (json.units != null) ? MuttableUnits.fromJson(json.units!) : null,
    structure: (json.structure != null)
        ? MuttableStructure.fromJson(json.structure!)
        : null,
  );

  JsonNode toJson() => JsonNode(
    x: x,
    y: y,
    type: type,
    units: units?.toJson(),
    structure: structure?.toJson(),
  );
}

class MuttableUnits {
  String player;
  int amount;

  MuttableUnits({required this.player, required this.amount});

  factory MuttableUnits.fromJson(JsonUnits json) =>
      MuttableUnits(player: json.player, amount: json.amount);

  JsonUnits toJson() => JsonUnits(player: player, amount: amount);
}

class MuttableStructure {
  StructureType type;
  String? player;
  String? platformId;

  MuttableStructure({
    required this.type,
    required this.player,
    required this.platformId,
  });

  factory MuttableStructure.fromJson(JsonStructure json) => MuttableStructure(
    type: json.type,
    player: json.player,
    platformId: json.platformId,
  );

  JsonStructure toJson() =>
      JsonStructure(type: type, player: player, platformId: platformId);
}
