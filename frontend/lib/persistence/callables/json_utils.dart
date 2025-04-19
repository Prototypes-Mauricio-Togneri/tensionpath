import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_structure.dart';
import 'package:tensionpath/domain/json/json_unit.dart';
import 'package:tensionpath/extensions/size_extension.dart';

class JsonUtils {
  // ================================= PLAYER =================================

  static JsonPlayer playerAddResources({
    required Player player,
    required int value,
  }) => JsonPlayer(
    id: player.id,
    name: player.name,
    resources: player.resources + value,
    resourcesRate: player.resourcesRate,
  );

  static JsonPlayer playerRemoveResources({
    required Player player,
    required int value,
  }) => JsonPlayer(
    id: player.id,
    name: player.name,
    resources: player.resources - value,
    resourcesRate: player.resourcesRate,
  );

  static JsonPlayer playerToJson(Player player) => JsonPlayer(
    id: player.id,
    name: player.name,
    resources: player.resources,
    resourcesRate: player.resourcesRate,
  );

  // ============================== BATTLEFIELD ================================

  static JsonBattlefield battlefieldDeployUnit({
    required Battlefield battlefield,
    required Unit unit,
    required Node nodeTarget,
  }) {
    final List<JsonNode> jsonNodes = [];

    for (final Node node in battlefield.nodes) {
      if (node == nodeTarget) {
        jsonNodes.add(nodeUnitDeployed(node: nodeTarget, unit: unit));
      } else {
        jsonNodes.add(nodeToJson(node));
      }
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      gridRatio: battlefield.gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
  }

  static JsonBattlefield battlefieldMoveUnit({
    required Battlefield battlefield,
    required Unit unit,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) {
    final List<JsonNode> jsonNodes = [];
    final Unit unit = nodeOrigin.unit!;

    for (final Node node in battlefield.nodes) {
      if (node == nodeOrigin) {
        jsonNodes.add(nodeUnitUndeployed(nodeOrigin));
      } else if (node == nodeTarget) {
        jsonNodes.add(nodeUnitMoved(node: nodeTarget, unit: unit));
      } else {
        jsonNodes.add(nodeToJson(node));
      }
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      gridRatio: battlefield.gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
  }

  static JsonBattlefield battlefieldResetUnits(Battlefield battlefield) {
    final List<JsonNode> jsonNodes = [];

    for (final Node node in battlefield.nodes) {
      jsonNodes.add(nodeUnitReset(node));
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      gridRatio: battlefield.gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
  }

  // ================================= NODE ===================================

  static JsonNode nodeUnitDeployed({required Node node, required Unit unit}) =>
      JsonNode(
        x: node.location.x,
        y: node.location.y,
        type: node.type,
        unit: unitToJson(unit),
        structure: structureToJson(node.structure),
      );

  static JsonNode nodeUnitMoved({required Node node, required Unit unit}) =>
      JsonNode(
        x: node.location.x,
        y: node.location.y,
        type: node.type,
        unit: unitReduceRemainingMoves(unit),
        structure: structureToJson(node.structure),
      );

  static JsonNode nodeUnitUndeployed(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: null,
    structure: structureToJson(node.structure),
  );

  static JsonNode nodeUnitReset(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: unitReset(node.unit),
    structure: structureToJson(node.structure),
  );

  static JsonNode nodeToJson(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: unitToJson(node.unit),
    structure: structureToJson(node.structure),
  );

  // ================================= UNIT ====================================

  static JsonUnit unitReduceRemainingMoves(Unit unit) => JsonUnit(
    type: unit.type,
    health: unit.health,
    remainingMoves: unit.remainingMoves - 1,
    remainingAttacks: unit.remainingAttacks,
    player: unit.player.id,
  );

  static JsonUnit? unitReset(Unit? unit) {
    if (unit != null) {
      return JsonUnit(
        type: unit.type,
        health: unit.health,
        remainingMoves: unit.type.movementRange,
        remainingAttacks: unit.remainingAttacks,
        player: unit.player.id,
      );
    } else {
      return null;
    }
  }

  static JsonUnit? unitToJson(Unit? unit) {
    if (unit != null) {
      return JsonUnit(
        type: unit.type,
        health: unit.health,
        remainingMoves: unit.remainingMoves,
        remainingAttacks: unit.remainingAttacks,
        player: unit.player.id,
      );
    } else {
      return null;
    }
  }

  // ================================= STRUCTURE ===============================

  static JsonStructure? structureToJson(Structure? structure) {
    if (structure != null) {
      return JsonStructure(type: structure.type, player: structure.player?.id);
    } else {
      return null;
    }
  }

  // ================================= MATCH ===================================

  static JsonMatch matchDeployUnit({
    required Match match,
    required Unit unit,
    required Node node,
  }) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: match.turn,
      activePlayer: match.activePlayer,
      players: [
        playerRemoveResources(
          player: match.self,
          value: unit.type.deploymentCost,
        ),
        playerToJson(match.opponent),
      ],
      battlefield: battlefieldDeployUnit(
        battlefield: match.battlefield,
        unit: unit,
        nodeTarget: node,
      ),
    );
  }

  static JsonMatch matchMoveUnit({
    required Match match,
    required Unit unit,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: match.turn,
      activePlayer: match.activePlayer,
      players: [
        playerRemoveResources(
          player: match.self,
          value: unit.type.movementCost,
        ),
        playerToJson(match.opponent),
      ],
      battlefield: battlefieldMoveUnit(
        battlefield: match.battlefield,
        unit: unit,
        nodeOrigin: nodeOrigin,
        nodeTarget: nodeTarget,
      ),
    );
  }

  static JsonMatch endTurnSelf(Match match) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: match.turn + 1,
      activePlayer: match.opponent.id,
      players: [
        playerAddResources(
          player: match.self,
          value: match.self.resourcesRate + match.fuelCollected,
        ),
        playerAddResources(
          player: match.opponent,
          value: match.accumulatedResourcesInTurn,
        ),
      ],
      battlefield: battlefieldResetUnits(match.battlefield),
    );
  }

  static JsonMatch endTurnOpponent(Match match) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: match.turn + 1,
      activePlayer: match.self.id,
      players: [
        JsonUtils.playerToJson(match.self),
        JsonUtils.playerToJson(match.opponent),
      ],
      battlefield: battlefieldResetUnits(match.battlefield),
    );
  }
}
