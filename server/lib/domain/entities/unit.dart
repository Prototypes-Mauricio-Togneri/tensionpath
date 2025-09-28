import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/nodes.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/logger.dart';
import 'package:uuid/uuid.dart';

class Unit {
  final Nodes nodes;
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
  Node? targetNode;
  Node? lockedNode;
  Unit? targetUnit;

  Unit({
    required this.nodes,
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
    currentAttackCooldown = type.attackCooldown;
    lockedNode = closestNode;
  }

  bool get isMoving => targetNode != null;

  bool get isAlive => health > 0;

  bool get isHarvesting =>
      (type == UnitType.harvester) &&
      (lockedNode != null) &&
      (lockedNode!.type == NodeType.resources);

  void move(Node node) {
    if (isHarvesting) {
      player.decreaseResourcesRate();
    }

    targetNode = node;
    lockedNode?.unlock();
    lockedNode = null;
    targetUnit = null;
  }

  void attack(Unit target) {
    targetUnit = target;
  }

  bool update(double dt) {
    bool result = false;

    if (isMoving) {
      Logger.debug('----------------------------------------\nMoving unit $id');

      // Update position
      position = position.moveTowards(
        target: targetNode!.position,
        distance: type.speed * dt,
      );

      final num distanceToTarget = position.distanceTo(targetNode!.position);
      Logger.debug(
        'Unit target ${targetNode!.location.id} / ${targetNode!.position}',
      );
      Logger.debug('New unit position $position');
      Logger.debug('Remaining distance: $distanceToTarget');

      if (distanceToTarget < 0.5) {
        Logger.debug(
          'Unit $id has arrived to the target node ${targetNode!.id}',
        );
        position = targetNode!.position;
        lockedNode = targetNode;
        lockedNode!.lock(this);
        targetNode = null;
        result = true;

        if (isHarvesting) {
          player.increaseResourcesRate();
        }
      } else if ((lockedNode == null) &&
          (distanceToTarget < (radius * 2)) &&
          targetNode!.notLockedBy(this)) {
        // Re-assign node
        targetNode = nodes.closestFreeNode(position);
        result = true;

        Logger.debug(
          'Unit target node was re-assigned to ${targetNode!.id}',
        );
      } else if ((lockedNode == null) &&
          (distanceToTarget < radius) &&
          targetNode!.isFree) {
        Logger.debug('Unit $id has locked the target node ${targetNode!.id}');
        lockedNode = targetNode;
        lockedNode!.lock(this);
      }
    } else {
      if (targetUnit != null && !targetUnit!.isAlive) {
        targetUnit = null;
        result = true;
      }

      // Assign the closest enemy in range if there is not one assigned
      if (targetUnit == null) {
        targetUnit = units.closestUnitInRange(this);

        if (targetUnit != null) {
          result = true;
          Logger.debug('Unit $id has re-targeted to ${targetUnit!.id}');
        }
      }

      if ((targetUnit != null) && (targetUnit!.isAlive)) {
        final num distanceToTarget = distanceTo(targetUnit!);

        if (isInAttackRange(distanceToTarget)) {
          if (currentAttackCooldown <= 0) {
            final num damage = type.damageAgainst(targetUnit!.type);
            currentAttackCooldown = type.attackCooldown;
            targetUnit!.hit(damage);
            result = true;
            Logger.debug(
              'Unit $id attacked unit ${targetUnit!.id} with $damage damage',
            );
          }
        }
      }
    }

    currentAttackCooldown -= dt;
    closestNode = nodes.atPosition(position);

    return result;
  }

  bool isInAttackRange(num distance) =>
      distance < (radius * (type.attackRange + 0.5));

  num distanceTo(Unit unit) => position.distanceTo(unit.position) - unit.radius;

  void hit(num damage) {
    health -= damage;

    if (health <= 0) {
      destroy();
    }
  }

  void destroy() {
    if (isHarvesting) {
      player.decreaseResourcesRate();
    }

    lockedNode?.unlock();
    lockedNode = null;
    targetNode = null;
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
    targetPosition: targetNode?.position.toJson(),
    lockedLocation: lockedNode?.location.toJson(),
    targetUnitId: targetUnit?.id,
  );

  static String get newId =>
      const Uuid().v4().replaceAll('-', '').substring(0, 16);

  @override
  bool operator ==(Object other) => other is Unit && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
