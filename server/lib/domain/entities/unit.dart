import 'package:tensionpath/domain/data/buildings.dart';
import 'package:tensionpath/domain/data/nodes.dart';
import 'package:tensionpath/domain/data/resources.dart';
import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/building.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/resource.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/logger.dart';
import 'package:uuid/uuid.dart';

class Unit {
  final Config config;
  final Nodes nodes;
  final Resources resources;
  final Buildings buildings;
  final Units units;
  final String id;
  final Player player;
  final UnitType type;
  final num radius;
  final num maxHealth;
  late num health;
  late num currentAttackCooldown;
  Position position;
  Node closestNode;
  Node? lockedNode;
  List<Node> targetNodes = [];
  Building? targetBase;
  Unit? targetUnit;
  bool lastOrderManual = false;

  Unit({
    required this.config,
    required this.nodes,
    required this.resources,
    required this.buildings,
    required this.units,
    required this.id,
    required this.player,
    required this.type,
    required this.radius,
    required this.closestNode,
    required this.position,
    required this.maxHealth,
  }) {
    health = maxHealth;
    currentAttackCooldown = 0;
    lockedNode = closestNode;
  }

  bool get isMoving => targetNodes.isNotEmpty;

  Node get nextTargetNode => targetNodes.first;

  bool get isLastTargetNode => targetNodes.length == 1;

  bool get isAlive => health > 0;

  bool get isHarvester => type == UnitType.harvester;

  bool get isInfantry => type.clazz == UnitClass.infantry;

  bool get isHarvesting =>
      isHarvester &&
      !isMoving &&
      (lockedNode != null) &&
      (lockedNode!.type == NodeType.resources) &&
      resources.get(lockedNode!.id).hasResources;

  JsonEvent move({
    required Node node,
    required bool manual,
  }) {
    lastOrderManual = manual;
    targetNodes = nodes.path(
      unit: this,
      from: closestNode,
      to: node,
    );
    lockedNode?.unlock();
    lockedNode = null;
    targetBase = null;
    targetUnit = null;

    return JsonEvent.unitMovementStarted(
      unitId: id,
      currentPosition: position.toJson(),
      targetPositions: targetNodes
          .map((node) => node.position.toJson())
          .toList(),
    );
  }

  void attackUnit(Unit target) {
    targetBase = null;

    if (canAttack(target)) {
      targetUnit = target;
    }
  }

  void attackBase(Building base) {
    if (canAttackStructures) {
      targetBase = base;
    }

    targetUnit = null;
  }

  (List<JsonEvent>, bool) update(double dt) {
    (List<JsonEvent>, bool) result;

    if (isMoving) {
      result = _processMoving(dt);
    } else {
      result = _processStanding(dt);
    }

    currentAttackCooldown -= dt;
    closestNode = nodes.atPosition(position);

    // Check if infantry is on resource patch
    if (isAlive && isInfantry && (closestNode.type == NodeType.resources)) {
      final Resource resource = resources.get(closestNode.id);

      if (resource.hasResources) {
        final num damage = config.resourcesDamage * dt;
        hit(damage);
        result.$1.add(
          JsonEvent.unitDamaged(
            unitId: id,
            damage: damage,
            unitDestroyed: !isAlive,
          ),
        );
      }
    }

    return result;
  }

  (List<JsonEvent>, bool) _processMoving(double dt) {
    final List<JsonEvent> events = [];
    bool updatePlayers = false;
    Logger.debug('----------------------------------------\nMoving unit $id');
    final Node targetNode = nextTargetNode;

    // Update position
    final num distance = type.speed.value * dt;
    Logger.debug('Distance $distance, speed ${type.speed.value}, dt $dt');
    final (Position, bool) movement = position.moveTowards(
      target: targetNode.position,
      distance: distance,
    );
    position = movement.$1;

    final num distanceToTarget = position.distanceTo(targetNode.position);
    Logger.debug('Target ${targetNode.location.id} / ${targetNode.position}');
    Logger.debug('Position $position');
    Logger.debug('Distance: $distanceToTarget');

    if (movement.$2) {
      position = targetNode.position;

      if (targetNodes.isNotEmpty) {
        targetNodes.removeAt(0);
      }

      if (targetNodes.isEmpty) {
        Logger.debug('Unit has arrived to final target node ${targetNode.id}');
        lockedNode = targetNode;
        lockedNode!.lock(this);
        events.add(
          JsonEvent.unitMovementEnded(
            unitId: id,
            currentPosition: position.toJson(),
            lockedLocation: lockedNode?.location.toJson(),
          ),
        );
        updatePlayers = isHarvester;
      } else {
        Logger.debug('Unit has arrived to next target node ${targetNode.id}');
      }
    } else if (_shouldRetarget(
      distanceToTarget: distanceToTarget,
      targetNode: targetNode,
      isLastNode: isLastTargetNode,
    )) {
      final Node? newTargetNode = nodes.closestNodeToMove(
        position: position,
        unit: this,
      );

      if (newTargetNode != null) {
        Logger.debug('Target node re-assigned to ${newTargetNode.id}');
        targetNodes = [newTargetNode];

        events.add(
          JsonEvent.unitMovementStarted(
            unitId: id,
            currentPosition: position.toJson(),
            targetPositions: targetNodes
                .map((node) => node.position.toJson())
                .toList(),
          ),
        );
      }
    } else if (_shouldLockNode(
      distanceToTarget: distanceToTarget,
      targetNode: targetNode,
    )) {
      Logger.debug('Unit has locked the target node ${targetNode.id}');
      lockedNode = targetNode;
      lockedNode!.lock(this);
    }

    return (events, updatePlayers);
  }

  (List<JsonEvent>, bool) _processStanding(double dt) {
    final List<JsonEvent> events = [];

    if (isHarvesting) {
      lastOrderManual = false;
      final Resource resource = resources.get(lockedNode!.id);

      if (resource.hasResources) {
        final num amount = resource.removeResources(
          player.resourcesActiveRate * dt,
        );
        player.addResources(amount);

        if (!resource.hasResources) {
          events.add(JsonEvent.resourceDepleted(resource.id));
        }
      }
    } else if (isHarvester && !lastOrderManual) {
      final Node? patchNode = nodes.closestNodeToHarvest(
        resources: resources,
        position: position,
        lockedNode: lockedNode,
      );

      if (patchNode != null) {
        Logger.debug('Harvester $id automatically moving to ${patchNode.id}');

        return (
          [
            move(
              node: patchNode,
              manual: false,
            ),
          ],
          true,
        );
      }
    }

    // Target unit is no longer alive
    if (targetUnit != null && !targetUnit!.isAlive) {
      Logger.debug('Target unit no longer alive');
      targetUnit = null;
    }

    // Assign the closest unit in range if there is not one assigned
    if ((targetUnit == null) && (targetBase == null)) {
      targetUnit = units.closestUnitInRange(this);

      if (targetUnit != null) {
        Logger.debug('Target unit retargeted to ${targetUnit!.id}');
      }

      // Assign the closest base in range if there is not one assigned
      if ((targetBase == null) && canAttackStructures) {
        targetBase = buildings.closestEnemyBaseInRange(this);

        if (targetBase != null) {
          Logger.debug('Target base retargeted to ${targetBase!.id}');
        }
      }
    }

    // Check if can shoot target unit
    if ((targetUnit != null) && (targetUnit!.isAlive)) {
      final num distanceToTarget = distanceToUnit(targetUnit!);

      if (isInAttackRange(distanceToTarget)) {
        if (currentAttackCooldown <= 0) {
          final num damage = type.damageAgainst(targetUnit!.type.clazz);
          currentAttackCooldown = type.attackCooldown;
          targetUnit!.hit(damage);

          if ((targetUnit!.type == UnitType.harvester) &&
              !targetUnit!.isAlive) {
            player.addResources(config.harvesterReward);
          }

          events.add(
            JsonEvent.unitAttack(
              attackerId: id,
              damage: damage,
              targetUnitId: targetUnit!.id,
              targetDestroyed: !targetUnit!.isAlive,
            ),
          );
          Logger.debug('Attacked unit ${targetUnit!.id} with $damage damage');
        }
      } else {
        // Previous target unit is out of range, retargeting
        targetUnit = units.closestUnitInRange(this);

        if (targetUnit != null) {
          Logger.debug('Target unit retargeted to ${targetUnit!.id}');
        }
      }
    } else if (targetBase != null) {
      // Check if can shoot target base
      final num distanceToTarget = distanceToBase(targetBase!);

      if (isInAttackRange(distanceToTarget)) {
        if (currentAttackCooldown <= 0) {
          final num damage = type.damageAgainst(UnitClass.structure);
          currentAttackCooldown = type.attackCooldown;
          targetBase!.player.removeHealth(damage);
          events.add(
            JsonEvent.unitAttack(
              attackerId: id,
              damage: damage,
              targetDestroyed: !targetBase!.player.isAlive,
              targetBaseLocation: targetBase!.location.toJson(),
            ),
          );
          Logger.debug('Attacked base ${targetBase!.id} with $damage damage');
        }
      }
    }

    return (events, false);
  }

  // TODO: re-target only if:
  // *
  bool _shouldRetarget({
    required num distanceToTarget,
    required Node targetNode,
    required bool isLastNode,
  }) {
    if ((lockedNode == null) && (distanceToTarget < (radius * 2))) {
      if (targetNode.notLockedByPlayer(player) &&
          !type.clazz.canGoOver(targetNode.lockedUnit!.type.clazz)) {
        // Node is locked by an enemy unit and cannot go over it
        return true;
      } else if (targetNode.lockedByPlayer(player) && isLastNode) {
        // Node is locked by a friendly unit and is last target node in the path
        return true;
      }
    }

    return false;
  }

  bool _shouldLockNode({
    required num distanceToTarget,
    required Node targetNode,
  }) =>
      (lockedNode == null) &&
      (distanceToTarget < radius) &&
      targetNode.isFree &&
      isLastTargetNode;

  bool canAttack(Unit unit) => type.damageAgainst(unit.type.clazz) > 0;

  bool get canAttackStructures => type.damageAgainst(UnitClass.structure) > 0;

  bool isInAttackRange(num distance) =>
      distance < (radius * (type.attackRange + 0.5));

  num distanceToUnit(Unit unit) =>
      position.distanceTo(unit.position) - unit.radius;

  num distanceToBase(Building building) =>
      position.distanceTo(building.position) - building.radius;

  void hit(num damage) {
    health -= damage;

    if (health <= 0) {
      destroy();
    }
  }

  void destroy() {
    lockedNode?.unlock();
    lockedNode = null;
    targetNodes = [];
    targetBase = null;
    targetUnit = null;
    health = 0;

    Logger.debug('Unit $id has been destroyed');
  }

  static String get newId =>
      const Uuid().v4().replaceAll('-', '').substring(0, 16);

  @override
  bool operator ==(Object other) => other is Unit && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
