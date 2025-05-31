import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/types/player_status.dart';

class JsonUtils {
  // ================================= PLAYER =================================

  /*static JsonPlayer playerToJson(JsonPlayer jsonPlayer) => JsonPlayer(
    name: jsonPlayer.name,
    baseHealth: jsonPlayer.baseHealth,
    resources: jsonPlayer.resources,
    status: jsonPlayer.status,
    turnEndedAt: jsonPlayer.turnEndedAt,
  );*/

  /*static JsonPlayer playerUpdate({
    required JsonPlayer jsonPlayer,
    required int baseMaxHealth,
    required int resourcesChange,
    required int healthChange,
    required DateTime? turnEndedAt,
  }) => JsonPlayer(
    name: jsonPlayer.name,
    baseHealth: (jsonPlayer.baseHealth - healthChange).clamp(0, baseMaxHealth),
    resources: jsonPlayer.resources + resourcesChange,
    status: turnEndedAt != null ? PlayerStatus.waiting : jsonPlayer.status,
    turnEndedAt: turnEndedAt ?? jsonPlayer.turnEndedAt,
  );*/

  static JsonPlayer playerNextTurn(JsonPlayer player) => JsonPlayer(
    name: player.name,
    baseHealth: player.baseHealth,
    resources: player.resources,
    status: PlayerStatus.playing,
    turnEndedAt: null,
  );

  // ================================ MISSILE ==================================

  /*static JsonMissile missileToJson(JsonMissile jsonMissile) => JsonMissile(
    charge: jsonMissile.charge,
    maxCharge: jsonMissile.maxCharge,
    platforms: jsonMissile.platforms,
  );*/

  /*static JsonMissile missileNextTurn(Missile missile) {
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
  }*/

  /*static int _missileNextCharge(Missile missile) {
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
  }*/

  /*static bool _missileFull(Missile missile) =>
      (missile.charge == missile.maxCharge) &&
      ((missile.owner == Constants.PLAYER_1) ||
          (missile.owner == Constants.PLAYER_2));*/

  // ============================== BATTLEFIELD ================================

  /*static JsonBattlefield battlefieldDeployUnit({
    required Battlefield battlefield,
    required Units units,
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
      missile: missileToJson(battlefield.missile),
      nodes: jsonNodes,
    );
  }*/

  /*static JsonBattlefield battlefieldMoveUnit({
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
      missile: missileToJson(battlefield.missile),
      nodes: jsonNodes,
    );
  }*/

  /*static JsonBattlefield battlefieldAttackUnit({
    required Battlefield battlefield,
    required Unit unitAttacker,
    required Unit unitDefender,
  }) {
    final List<JsonNode> jsonNodes = [];

    final int attackerDamage = unitAttacker.damageTo(unitDefender);
    final int defenderDamage = unitDefender.damageTo(unitAttacker);

    final bool attackerCanAttack = unitAttacker.isInRange(unitDefender);
    final bool defenderCanAttack = unitDefender.isInRange(unitAttacker);

    int attackerHealth = unitAttacker.health;
    const int attackerRemainingMoves = 0;
    final int attackerRemainingAttacks = unitAttacker.remainingAttacks - 1;

    int defenderHealth = unitDefender.health;
    final int defenderRemainingMoves = unitDefender.remainingMoves;
    final int defenderRemainingAttacks = unitDefender.remainingAttacks;

    if (unitAttacker.remainingMoves == unitAttacker.type.movementRange) {
      // Attacker shoots first
      if (attackerCanAttack) {
        defenderHealth = unitDefender.health - attackerDamage;
      }

      // If defender is still alive, it shoots back
      if ((defenderHealth > 0) && defenderCanAttack) {
        attackerHealth = unitAttacker.health - defenderDamage;
      }
    } else {
      // Defender shoots first
      if (defenderCanAttack) {
        attackerHealth = unitAttacker.health - defenderDamage;
      }

      // If attacker is still alive, it shoots back
      if ((attackerHealth > 0) && attackerCanAttack) {
        defenderHealth = unitDefender.health - attackerDamage;
      }
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
      missile: missileToJson(battlefield.missile),
      nodes: jsonNodes,
    );
  }*/

  /*static JsonBattlefield battlefieldAttackBase({
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
      missile: missileToJson(battlefield.missile),
      nodes: jsonNodes,
    );
  }*/

  /*static JsonBattlefield battlefieldNexTurn(Battlefield battlefield) {
    final List<JsonNode> jsonNodes = [];

    for (final Node node in battlefield.nodes) {
      jsonNodes.add(nodeUnitReset(node));
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      missile: missileNextTurn(battlefield.missile),
      nodes: jsonNodes,
    );
  }*/

  /*static JsonBattlefield battlefieldToJson(JsonBattlefield jsonBattlefield) =>
      JsonBattlefield(
        id: jsonBattlefield.id,
        size: jsonBattlefield.size,
        missile: jsonBattlefield.missile,
        nodes: jsonBattlefield.nodes,
      );*/

  /*static JsonBattlefield battlefieldWithActions(Battlefield battlefield) {
    final List<JsonNode> jsonNodes = [];

    for (final Node node in battlefield.nodes) {
      jsonNodes.add(nodeToJson(node));
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      missile: missileToJson(battlefield.missile),
      nodes: jsonNodes,
    );
  }*/

  // ================================= NODE ===================================

  /*static JsonNode nodeUnitDeployed({required Node node, required Unit unit}) =>
      JsonNode(
        x: node.location.x,
        y: node.location.y,
        type: node.type,
        unit: unitToJson(unit),
        structure: structureToJson(node.structure),
      );*/

  /*static JsonNode nodeUnitUndeployed(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: null,
    structure: structureToJson(node.structure),
  );*/

  /*static JsonNode nodeUnitMoved({
    required Node node,
    required Unit unit,
    required int distance,
  }) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: unitMoved(unit: unit, distance: distance),
    structure: structureToJson(node.structure),
  );*/

  /*static JsonNode nodeUnitBattled({
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
  );*/

  /*static JsonNode nodeUnitReset(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: unitReset(node: node, unit: node.unit),
    structure: structureToJson(node.structure),
  );*/

  /*static JsonNode nodeToJson(Node node) => JsonNode(
    x: node.location.x,
    y: node.location.y,
    type: node.type,
    unit: unitToJson(node.units),
    structure: structureToJson(node.structure),
  );*/

  // ================================= UNIT ====================================

  /*static JsonUnits unitMoved({required Unit unit, required int distance}) =>
      JsonUnits(
        type: unit.type,
        health: unit.health,
        remainingMoves: unit.remainingMoves - distance,
        remainingAttacks: unit.remainingAttacks,
        player: unit.player.id,
      );*/

  /*static JsonUnits unitBattled({
    required Unit unit,
    required int health,
    required int remainingMoves,
    required int remainingAttacks,
  }) => JsonUnits(
    type: unit.type,
    health: health,
    remainingMoves: remainingMoves,
    remainingAttacks: remainingAttacks,
    player: unit.player.id,
  );*/

  /*static JsonUnits? unitReset({required Node node, required Unit? unit}) {
    if (unit != null) {
      final bool isResourcesStructure =
          node.hasStructure && (node.structure is StructureResources);
      final bool isUnitInfantry = unit.type.unitClass == UnitClass.infantry;
      final int extraDamage =
          ((isResourcesStructure && isUnitInfantry) ? FUEL_PATCH_DAMAGE : 0);
      final int health = unit.health - extraDamage;

      if (health > 0) {
        return JsonUnits(
          type: unit.type,
          health: health,
          remainingMoves: unit.type.movementRange,
          remainingAttacks: unit.type.numberOfAttacks,
          player: unit.player.id,
        );
      } else {
        return null;
      }
    } else {
      return null;
    }
  }*/

  /*static JsonUnits? unitToJson(Units? units) {
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
  }*/

  // ================================= STRUCTURE ===============================

  /*static JsonStructure? structureToJson(Structure? structure) {
    if (structure != null) {
      return JsonStructure(
        type: structure.type,
        player: structure.getPlayerId,
        platformId: structure.getPlatformId,
      );
    } else {
      return null;
    }
  }*/

  // ================================= CONFIG ==================================

  /*static JsonConfig configToJson(Config config) => JsonConfig(
    popcap: config.popcap,
    baseMaxHealth: config.baseMaxHealth,
    resourcesPerPatch: config.resourcesPerPatch,
    resourcesPerTurn: config.resourcesPerTurn,
    resourcesPerSecond: config.resourcesPerSecond,
  );*/

  // ================================= TURN ====================================

  static JsonTurn nextTurn(JsonTurn jsonTurn) =>
      JsonTurn(turn: jsonTurn.turn + 1, startedAt: DateTime.now());

  // ================================= MATCH ===================================

  /*static JsonMatch matchDeployUnit({
    required Match match,
    required Unit unit,
    required Node node,
  }) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: turnToJson(match.turn),
      config: configToJson(match.config),
      players: [
        playerUpdate(
          player: match.self,
          resourcesChange: -unit.type.deploymentCost,
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
  }*/

  /*static JsonMatch matchMoveUnit({
    required Match match,
    required Unit unitOrigin,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: turnToJson(match.turn),
      config: configToJson(match.config),
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
  }*/

  /*static JsonMatch matchAttackUnit({
    required Match match,
    required Unit unitAttacker,
    required Unit unitDefender,
  }) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: turnToJson(match.turn),
      config: configToJson(match.config),
      players: [playerToJson(match.self), playerToJson(match.opponent)],
      battlefield: battlefieldAttackUnit(
        battlefield: match.battlefield,
        unitAttacker: unitAttacker,
        unitDefender: unitDefender,
      ),
    );
  }*/

  /*static JsonMatch matchAttackBase({
    required Match match,
    required Unit unit,
    required Node node,
  }) {
    final int damage = unit.type.damageStructure;

    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      turn: turnToJson(match.turn),
      config: configToJson(match.config),
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
  }*/

  static JsonMatch nexTurn(JsonMatch json) {
    return JsonMatch(
      id: json.id,
      version: json.version,
      createdAt: json.createdAt,
      config: json.config,
      turn: nextTurn(json.turn),
      players: Map.fromEntries(
        json.players.entries.map(
          (entry) => MapEntry(entry.key, playerNextTurn(entry.value)),
        ),
      ),
      battlefield: json.battlefield,
    );
  }

  /*static int _newResources({required Player player, required Match match}) =>
      match.config.resourcesPerTurn +
      _fuelCollected(
        match: match,
        player: player,
        nodes: match.battlefield.nodes,
      ) +
      match.accumulatedResourcesInTurn;*/

  /*static int _missileHit({required Player player, required Missile missile}) {
    if (_missileFull(missile)) {
      if (missile.owner != player.id) {
        return player.baseMaxHealth ~/ 2;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }*/

  /*static int _fuelCollected({
    required Match match,
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
          result += match.config.resourcesPerPatch;
        }
      }
    }

    return result;
  }*/
}

DateTime? dateToJson(DateTime? dateTime) => dateTime?.toUtc();
