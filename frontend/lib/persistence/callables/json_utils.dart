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
    if (_missileFull(missile)) {
      return JsonMissile(
        charge: 0,
        maxCharge: missile.maxCharge,
        platforms: missile.numberOfPlatforms,
      );
    } else {
      return JsonMissile(
        charge: _missileNextCharge(missile),
        maxCharge: missile.maxCharge,
        platforms: missile.numberOfPlatforms,
      );
    }
  }

  static int _missileNextCharge(Missile missile) {
    final String? owner = missile.owner;
    final bool charging =
        owner == Constants.PLAYER_1 || owner == Constants.PLAYER_2;

    if (charging) {
      return missile.charge + 1;
    } else if ((owner == '') && (missile.charge > missile.bufferCharge)) {
      return missile.charge - 1;
    } else {
      return missile.charge;
    }
  }

  static bool _missileFull(Missile missile) =>
      (missile.charge == missile.maxCharge) &&
      ((missile.owner == Constants.PLAYER_1) ||
          (missile.owner == Constants.PLAYER_2));

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
    required Node nodeOrigin,
    required Node nodeTarget,
  }) {
    final List<JsonNode> jsonNodes = [];
    final Unit unit = nodeOrigin.unit!;
    final int distance = nodeOrigin.distance(nodeTarget);

    for (final Node node in battlefield.nodes) {
      if (node == nodeOrigin) {
        jsonNodes.add(nodeUnitUndeployed(nodeOrigin));
      } else if (node == nodeTarget) {
        jsonNodes.add(
          nodeUnitMoved(node: nodeTarget, unit: unit, distance: distance),
        );
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

    final int attackerDamage = unitAttacker.damageTo(unitDefender);
    final int defenderDamage = unitDefender.damageTo(unitAttacker);

    final int attackerHealth = unitAttacker.health - defenderDamage;
    const int attackerRemainingMoves = 0;
    final int attackerRemainingAttacks = unitAttacker.remainingAttacks - 1;

    int defenderHealth = unitDefender.health;
    final int defenderRemainingMoves = unitDefender.remainingMoves;
    final int defenderRemainingAttacks = unitDefender.remainingAttacks;

    // Attacker shoots if:
    // * It is in a defensive position (i.e. didn't move before)
    // * It just moved but it's still alive
    if ((unitAttacker.remainingMoves == unitAttacker.type.movementRange) &&
        (attackerHealth > 0)) {
      defenderHealth = unitDefender.health - attackerDamage;
    }

    for (final Node node in battlefield.nodes) {
      if (node.hasUnit) {
        if (node.unit == unitAttacker) {
          jsonNodes.add(
            nodeUnitBattled(
              node: node,
              unit: (attackerHealth > 0) ? unitAttacker : null,
              health: attackerHealth,
              remainingMoves: attackerRemainingMoves,
              remainingAttacks: attackerRemainingAttacks,
            ),
          );
        } else if (node.unit == unitDefender) {
          jsonNodes.add(
            nodeUnitBattled(
              node: node,
              unit: (defenderHealth > 0) ? unitDefender : null,
              health: defenderHealth,
              remainingMoves: defenderRemainingMoves,
              remainingAttacks: defenderRemainingAttacks,
            ),
          );
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

  static JsonBattlefield battlefieldAttackBase({
    required Battlefield battlefield,
    required Unit unit,
  }) {
    final List<JsonNode> jsonNodes = [];

    for (final Node node in battlefield.nodes) {
      if (node.hasUnit && (node.unit == unit)) {
        jsonNodes.add(
          nodeUnitBattled(
            node: node,
            unit: unit,
            health: unit.health,
            remainingMoves: 0,
            remainingAttacks: unit.remainingAttacks - 1,
          ),
        );
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

  static JsonBattlefield battlefieldToJson(Battlefield battlefield) =>
      JsonBattlefield(
        id: battlefield.id,
        size: battlefield.size.toJsonSize(),
        gridRatio: battlefield.gridRatio.toJsonRatio(),
        missile: missileToJson(battlefield.missile),
        nodes: battlefield.nodes.map(nodeToJson).toList(),
      );

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

  static JsonNode nodeUnitMoved({
    required Node node,
    required Unit unit,
    required int distance,
  }) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: unitMoved(unit: unit, distance: distance),
    structure: structureToJson(node.structure),
  );

  static JsonNode nodeUnitBattled({
    required Node node,
    required Unit? unit,
    required int health,
    required int remainingMoves,
    required int remainingAttacks,
  }) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit:
        (unit != null)
            ? unitBattled(
              unit: unit,
              health: health,
              remainingMoves: remainingMoves,
              remainingAttacks: remainingAttacks,
            )
            : null,
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

  static JsonUnit unitMoved({required Unit unit, required int distance}) =>
      JsonUnit(
        type: unit.type,
        health: unit.health,
        remainingMoves: unit.remainingMoves - distance,
        remainingAttacks: unit.remainingAttacks,
        player: unit.player.id,
      );

  static JsonUnit unitBattled({
    required Unit unit,
    required int health,
    required int remainingMoves,
    required int remainingAttacks,
  }) => JsonUnit(
    type: unit.type,
    health: health,
    remainingMoves: remainingMoves,
    remainingAttacks: remainingAttacks,
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
    required Unit unitOrigin,
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
          resourcesChange: -unitOrigin.type.movementCost,
          healthChange: 0,
        ),
        playerToJson(match.opponent),
      ],
      battlefield: battlefieldMoveUnit(
        battlefield: match.battlefield,
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

  static JsonMatch matchAttackBase({
    required Match match,
    required Unit unit,
    required Node node,
  }) {
    final int damage = unit.type.damageStructure;

    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: match.turn,
      lastTurnStartedAt: match.lastTurnStartedAt,
      activePlayer: match.activePlayer,
      players: [
        playerToJson(match.self),
        playerUpdate(
          player: match.opponent,
          resourcesChange: 0,
          healthChange: damage,
        ),
      ],
      battlefield: battlefieldAttackBase(
        battlefield: match.battlefield,
        unit: unit,
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
    if (_missileFull(missile)) {
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
