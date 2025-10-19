import 'package:tensionpath/domain/data/launchers.dart';
import 'package:tensionpath/domain/data/nodes.dart';
import 'package:tensionpath/domain/data/resources.dart';
import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/launcher.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/resource.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/logger.dart';
import 'package:uuid/uuid.dart';

class Unit {
  final Config config;
  final Nodes nodes;
  final Resources resources;
  final Launchers launchers;
  final Units units;
  final String id;
  final Player player;
  final UnitType type;
  final num radius;
  final num maxHealth;
  late num health; // updated by frontend, corrected by server
  late num currentAttackCooldown;
  Position position; // updated by frontend, corrected by server
  Node closestNode; // updated by frontend
  Node? lockedNode; // set by server
  Node? targetNode; // updated by frontend, corrected by server
  Launcher? targetBase; // updated by frontend, corrected by server
  Unit? targetUnit; // updated by frontend, corrected by server
  bool lastOrderManual = false;

  Unit({
    required this.config,
    required this.nodes,
    required this.resources,
    required this.launchers,
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

  bool get isMoving => targetNode != null;

  bool get isAlive => health > 0;

  bool get isHarvesting =>
      (type == UnitType.harvester) &&
      !isMoving &&
      (lockedNode != null) &&
      (lockedNode!.type == NodeType.resources) &&
      resources.get(lockedNode!.id).hasResources;

  JsonEvent move({
    required Node node,
    required bool manual,
  }) {
    lastOrderManual = manual;
    targetNode = node;
    lockedNode?.unlock();
    lockedNode = null;
    targetBase = null;
    targetUnit = null;

    return JsonEvent.unitMovementStarted(
      unitId: id,
      currentPosition: position.toJson(),
      targetPosition: targetNode!.position.toJson(),
    );
  }

  void attackUnit(Unit target) {
    targetBase = null;

    if (canAttack(target)) {
      targetUnit = target;
    }
  }

  void attackBase(Launcher base) {
    if (canAttackStructures) {
      targetBase = base;
    }

    targetUnit = null;
  }

  JsonEvent? update(double dt) {
    JsonEvent? result;

    if (isMoving) {
      result = _processMoving(dt);
    } else {
      result = _processStanding(dt);
    }

    currentAttackCooldown -= dt;
    closestNode = nodes.atPosition(position);

    return result;
  }

  JsonEvent? _processMoving(double dt) {
    JsonEvent? result;
    Logger.debug('----------------------------------------\nMoving unit $id');

    // Update position
    position = position.moveTowards(
      target: targetNode!.position,
      distance: type.speed * dt,
    );

    final num distanceToTarget = position.distanceTo(targetNode!.position);
    Logger.debug('Target ${targetNode!.location.id} / ${targetNode!.position}');
    Logger.debug('Position $position');
    Logger.debug('Distance: $distanceToTarget');

    if (distanceToTarget < 0.5) {
      Logger.debug('Unit has arrived at the target node ${targetNode!.id}');
      position = targetNode!.position;
      lockedNode = targetNode;
      lockedNode!.lock(this);
      targetNode = null;
      result = JsonEvent.unitMovementEnded(
        unitId: id,
        currentPosition: position.toJson(),
        lockedLocation: lockedNode?.location.toJson(),
      );
    } else if ((lockedNode == null) &&
        (distanceToTarget < (radius * 2)) &&
        targetNode!.notLockedBy(this)) {
      Logger.debug('Target node re-assigned to ${targetNode!.id}');
      // Target node is already locked. Re-assign node
      targetNode = nodes.closestNodeToMove(
        position: position,
        unit: this,
      );
      result = JsonEvent.unitMovementStarted(
        unitId: id,
        currentPosition: position.toJson(),
        targetPosition: targetNode!.position.toJson(),
      );
    } else if ((lockedNode == null) &&
        (distanceToTarget < radius) &&
        targetNode!.isFree) {
      Logger.debug('Unit has locked the target node ${targetNode!.id}');
      lockedNode = targetNode;
      lockedNode!.lock(this);
    }

    return result;
  }

  JsonEvent? _processStanding(double dt) {
    JsonEvent? result;

    if (isHarvesting) {
      lastOrderManual = false;
      final Resource resource = resources.get(lockedNode!.id);
      final num amount = resource.removeResources(
        player.resourcesActiveRate * dt,
      );
      player.addResources(amount);
    } else if ((type == UnitType.harvester) && !lastOrderManual) {
      final Node? patchNode = nodes.closestNodeToHarvest(
        resources: resources,
        position: position,
        lockedNode: lockedNode,
      );

      if (patchNode != null) {
        Logger.debug('Harvester $id automatically moving to ${patchNode.id}');

        return move(
          node: patchNode,
          manual: false,
        );
      }
    }

    // Target unit is no longer alive
    if (targetUnit != null && !targetUnit!.isAlive) {
      targetUnit = null;
      // TODO(momo): result = JsonEvent.unitUpdated(this);
    }

    // Assign the closest unit in range if there is not one assigned
    if ((targetUnit == null) && (targetBase == null)) {
      targetUnit = units.closestUnitInRange(this);

      if (targetUnit != null) {
        // TODO(momo): result = JsonEvent.unitUpdated(this);
        Logger.debug('Unit retargeted to unit ${targetUnit!.id}');
      }

      // Assign the closest base in range if there is not one assigned
      if ((targetBase == null) && canAttackStructures) {
        targetBase = launchers.closestEnemyBaseInRange(this);

        if (targetBase != null) {
          // TODO(momo): result = JsonEvent.unitUpdated(this);
          Logger.debug('Unit retargeted to base ${targetBase!.id}');
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

          // TODO(momo): result = JsonEvent.unitUpdated(this);
          Logger.debug('Attacked unit ${targetUnit!.id} with $damage damage');
        }
      } else {
        // Previous target unit is out of range, retargeting
        targetUnit = units.closestUnitInRange(this);

        if (targetUnit != null) {
          // TODO(momo): result = JsonEvent.unitUpdated(this);
          Logger.debug('Unit retargeted to unit ${targetUnit!.id}');
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
          // TODO(momo): result = JsonEvent.unitUpdated(this);
          Logger.debug('Attacked unit ${targetBase!.id} with $damage damage');
        }
      }
    }

    return result;
  }

  bool canAttack(Unit unit) => type.damageAgainst(unit.type.clazz) > 0;

  bool get canAttackStructures => type.damageAgainst(UnitClass.structure) > 0;

  bool isInAttackRange(num distance) =>
      distance < (radius * (type.attackRange + 0.5));

  num distanceToUnit(Unit unit) =>
      position.distanceTo(unit.position) - unit.radius;

  num distanceToBase(Launcher launcher) =>
      position.distanceTo(launcher.position) - launcher.radius;

  void hit(num damage) {
    health -= damage;

    if (health <= 0) {
      destroy();
    }
  }

  void destroy() {
    lockedNode?.unlock();
    lockedNode = null;
    targetNode = null;
    targetBase = null;
    targetUnit = null;
    health = 0;

    Logger.debug('Unit $id has been destroyed');
  }

  JsonUnitUpdate toJsonUpdate() => JsonUnitUpdate(
    id: id,
    playerIndex: player.index,
    type: type,
    maxHealth: maxHealth,
    health: health,
    currentPosition: position.toJson(),
    lockedLocation: lockedNode?.location.toJson(),
    targetPosition: targetNode?.position.toJson(),
    targetBase: targetBase?.location.toJson(),
    targetUnitId: targetUnit?.id,
  );

  static String get newId =>
      const Uuid().v4().replaceAll('-', '').substring(0, 16);

  @override
  bool operator ==(Object other) => other is Unit && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
