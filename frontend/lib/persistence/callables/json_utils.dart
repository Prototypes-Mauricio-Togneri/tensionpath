import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/entities/units/unit_fuel_truck.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_structure.dart';
import 'package:tensionpath/domain/json/json_unit.dart';
import 'package:tensionpath/extensions/size_extension.dart';

class JsonUtils {
  // ================================= PLAYER =================================

  /*static JsonPlayer playerAddResources({
    required Player player,
    required int value,
  }) => JsonPlayer(
    id: player.id,
    name: player.name,
    baseHealth: player.baseHealth,
    baseMaxHealth: player.baseMaxHealth,
    resources: player.resources + value,
    resourcesRate: player.resourcesRate,
  );

  static JsonPlayer playerRemoveResources({
    required Player player,
    required int value,
  }) => JsonPlayer(
    id: player.id,
    name: player.name,
    baseHealth: player.baseHealth,
    baseMaxHealth: player.baseMaxHealth,
    resources: player.resources - value,
    resourcesRate: player.resourcesRate,
  );

  static JsonPlayer playerReduceHealth({
    required Player player,
    required int value,
  }) => JsonPlayer(
    id: player.id,
    name: player.name,
    baseHealth: (player.baseHealth - value).clamp(0, player.baseMaxHealth),
    baseMaxHealth: player.baseMaxHealth,
    resources: player.resources,
    resourcesRate: player.resourcesRate,
  );*/

  static JsonPlayer playerToJson(Player player) => JsonPlayer(
    id: player.id,
    name: player.name,
    baseHealth: player.baseHealth,
    baseMaxHealth: player.baseMaxHealth,
    resources: player.resources,
    resourcesRate: player.resourcesRate,
  );

  static JsonPlayer playerUpdate({
    required Player player,
    required int resourcesChange,
    required int healthChange,
  }) => JsonPlayer(
    id: player.id,
    name: player.name,
    baseHealth: (player.baseHealth - healthChange).clamp(
      0,
      player.baseMaxHealth,
    ),
    baseMaxHealth: player.baseMaxHealth,
    resources: player.resources + resourcesChange,
    resourcesRate: player.resourcesRate,
  );

  // ================================ MISSILE ==================================

  static JsonMissile missileToJson(Missile missile) => JsonMissile(
    charge: missile.charge,
    maxCharge: missile.maxCharge,
    platforms: missile.numberOfPlatforms,
  );

  static JsonMissile missileNextTurn(Missile missile) {
    if (missile.isFull) {
      return JsonMissile(
        charge: 0,
        maxCharge: missile.maxCharge,
        platforms: missile.numberOfPlatforms,
      );
    } else {
      final String? owner = missile.owner;
      final bool charging =
          owner == Constants.PLAYER_1 || owner == Constants.PLAYER_2;

      return JsonMissile(
        charge: charging ? missile.charge + 1 : missile.charge,
        maxCharge: missile.maxCharge,
        platforms: missile.numberOfPlatforms,
      );
    }
  }

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
      missile: missileToJson(battlefield.missile),
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
      missile: missileToJson(battlefield.missile),
      nodes: jsonNodes,
    );
  }

  static JsonBattlefield battlefieldAttackUnit({
    required Battlefield battlefield,
    required Unit unitAttacker,
    required Unit unitDefender,
  }) {
    final List<JsonNode> jsonNodes = [];
    final List<Unit?> battle = unitAttacker.battle(
      attacker: unitAttacker,
      defender: unitDefender,
    );
    final Unit? attackerResult = battle.first;
    final Unit? defenderResult = battle.last;

    for (final Node node in battlefield.nodes) {
      if (node.hasUnit) {
        if (node.unit == unitAttacker) {
          jsonNodes.add(nodeUnitAttacked(node: node, unit: attackerResult));
        } else if (node.unit == unitDefender) {
          jsonNodes.add(nodeUnitAttacked(node: node, unit: defenderResult));
        } else {
          jsonNodes.add(nodeToJson(node));
        }
      } else {
        jsonNodes.add(nodeToJson(node));
      }
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      gridRatio: battlefield.gridRatio.toJsonRatio(),
      missile: missileToJson(battlefield.missile),
      nodes: jsonNodes,
    );
  }

  static JsonBattlefield battlefieldNexTurn(Battlefield battlefield) {
    final List<JsonNode> jsonNodes = [];

    for (final Node node in battlefield.nodes) {
      jsonNodes.add(nodeUnitReset(node));
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      gridRatio: battlefield.gridRatio.toJsonRatio(),
      missile: missileNextTurn(battlefield.missile),
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

  static JsonNode nodeUnitUndeployed(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: null,
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

  static JsonNode nodeUnitAttacked({required Node node, required Unit? unit}) =>
      JsonNode(
        x: node.location.x,
        y: node.location.y,
        type: node.type,
        unit: unitToJson(unit),
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
        remainingAttacks: unit.type.numberOfAttacks,
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
      return JsonStructure(
        type: structure.type,
        player: structure.getPlayerId,
        platformId: structure.getPlatformId,
      );
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
      lastTurnStartedAt: match.lastTurnStartedAt,
      activePlayer: match.activePlayer,
      players: [
        playerUpdate(
          player: match.self,
          resourcesChange: unit.type.deploymentCost,
          healthChange: 0,
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
      lastTurnStartedAt: match.lastTurnStartedAt,
      activePlayer: match.activePlayer,
      players: [
        playerUpdate(
          player: match.self,
          resourcesChange: unit.type.movementCost,
          healthChange: 0,
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

  static JsonMatch matchAttackUnit({
    required Match match,
    required Unit unitAttacker,
    required Unit unitDefender,
  }) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: match.turn,
      lastTurnStartedAt: match.lastTurnStartedAt,
      activePlayer: match.activePlayer,
      players: [playerToJson(match.self), playerToJson(match.opponent)],
      battlefield: battlefieldAttackUnit(
        battlefield: match.battlefield,
        unitAttacker: unitAttacker,
        unitDefender: unitDefender,
      ),
    );
  }

  static JsonMatch endTurnSelf(Match match) => JsonMatch(
    id: match.id,
    version: match.version,
    createdAt: match.createdAt,
    turn: match.turn + 1,
    lastTurnStartedAt: DateTime.now(),
    activePlayer: match.opponent.id,
    players: [
      playerUpdate(
        player: match.self,
        resourcesChange: 0,
        healthChange: _missileHit(
          player: match.self,
          missile: match.battlefield.missile,
        ),
      ),
      playerUpdate(
        player: match.opponent,
        resourcesChange: _newResources(player: match.opponent, match: match),
        healthChange: _missileHit(
          player: match.opponent,
          missile: match.battlefield.missile,
        ),
      ),
    ],
    battlefield: battlefieldNexTurn(match.battlefield),
  );

  static JsonMatch endTurnOpponent(Match match) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: match.turn + 1,
      lastTurnStartedAt: DateTime.now(),
      activePlayer: match.self.id,
      players: [
        playerUpdate(
          player: match.opponent,
          resourcesChange: 0,
          healthChange: _missileHit(
            player: match.opponent,
            missile: match.battlefield.missile,
          ),
        ),
        playerUpdate(
          player: match.self,
          resourcesChange: _newResources(player: match.self, match: match),
          healthChange: _missileHit(
            player: match.self,
            missile: match.battlefield.missile,
          ),
        ),
      ],
      battlefield: battlefieldNexTurn(match.battlefield),
    );
  }

  static int _newResources({required Player player, required Match match}) =>
      player.resourcesRate +
      _fuelCollected(player: player, nodes: match.battlefield.nodes) +
      match.accumulatedResourcesInTurn;

  static int _missileHit({required Player player, required Missile missile}) {
    if (missile.isFull) {
      if (missile.owner != player.id) {
        return player.baseMaxHealth ~/ 2;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  static int _fuelCollected({
    required Player player,
    required List<Node> nodes,
  }) {
    int result = 0;

    for (final Node node in nodes) {
      if (node.hasStructure && node.hasUnit) {
        final Structure structure = node.structure!;
        final Unit unit = node.unit!;

        if ((structure is StructureResources) &&
            unit.belongsTo(player) &&
            (unit is UnitFuelTruck)) {
          result += Constants.FUEL_TRUCK_COLLECTION;
        }
      }
    }

    return result;
  }
}

DateTime dateToJson(DateTime dateTime) => dateTime.toUtc();
