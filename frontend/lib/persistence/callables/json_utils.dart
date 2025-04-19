import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_unit.dart';
import 'package:tensionpath/extensions/size_extension.dart';

class JsonUtils {
  // ================================= PLAYER =================================

  static JsonPlayer playerSpendResources({
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

  // ================================= UNIT ====================================

  static JsonUnit unitIncreaseMoves(Unit unit) => JsonUnit(
    type: unit.type,
    health: unit.health,
    moves: unit.remainingMoves - 1,
    player: unit.player.id,
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
        jsonNodes.add(nodeTarget.withUnitDeployed(unit.toJson()));
      } else {
        jsonNodes.add(node.toJson());
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
        jsonNodes.add(nodeOrigin.withUnitUndeployed());
      } else if (node == nodeTarget) {
        jsonNodes.add(nodeTarget.withUnitDeployed(unitIncreaseMoves(unit)));
      } else {
        jsonNodes.add(node.toJson());
      }
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      gridRatio: battlefield.gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
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
        playerSpendResources(
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
        playerSpendResources(player: match.self, value: unit.type.movementCost),
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
}
