import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/nodes.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:uuid/uuid.dart';

class Unit {
  final String id;
  final Player player;
  final UnitType type;
  final num radius;
  final num damage;
  final num attackCooldown;
  final num maxHealth;
  late num health;
  late num currentAttackCooldown;
  Position position;
  Node closestNode;
  Node? targetNode;
  Node? lockedNode;
  Unit? targetUnit;

  Unit({
    required this.id,
    required this.player,
    required this.type,
    required this.radius,
    required this.damage,
    required this.attackCooldown,
    required this.closestNode,
    required this.position,
    required this.maxHealth,
  }) {
    health = maxHealth;
    currentAttackCooldown = attackCooldown;
    lockedNode = closestNode;
  }

  bool get isMoving => targetNode != null;

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
  }

  void attack(Unit target) {
    targetUnit = target;
  }

  bool update({
    required double dt,
    required Nodes nodes,
  }) {
    bool result = false;

    if (isMoving) {
      print('--------------------------------------------\nMoving unit $id');

      if (targetNode!.notLockedBy(this)) {
        // Re-assign node
        targetNode = nodes.closestFreeNode(position);
        result = true;

        print(
          'Unit target node was re-assigned to ${targetNode!.id}',
        );
      }

      // Update position
      position = position.moveTowards(
        target: targetNode!.position,
        distance: type.speed * dt,
      );

      final num distanceToTarget = position.distanceTo(targetNode!.position);
      print('Unit target ${targetNode!.location.id} / ${targetNode!.position}');
      print('New unit position $position');
      print('Remaining distance: $distanceToTarget');

      if (distanceToTarget < 0.5) {
        print('Unit $id has arrived to the target node ${targetNode!.id}');
        // If the unit has arrived to the target node -> stop moving
        position = targetNode!.position;
        lockedNode = targetNode;
        lockedNode!.lock(this);
        targetNode = null;
        result = true;

        if (isHarvesting) {
          player.increaseResourcesRate();
        }
      } else if ((lockedNode == null) && (distanceToTarget < radius)) {
        print('Unit $id has locked the target node ${targetNode!.id}');
        // If the unit is inside of target node -> assign node to unit
        lockedNode = targetNode;
        lockedNode!.lock(this);
      }
    } else {
      if (targetUnit == null) {
        // TODO(momo): assign closest enemy unit in range
      }

      if (targetUnit != null) {
        final num distanceToTarget = position.distanceTo(targetUnit!.position);

        if (distanceToTarget < (radius * 2.5)) {
          currentAttackCooldown -= dt;

          if (currentAttackCooldown <= 0) {
            currentAttackCooldown = attackCooldown;
            targetUnit!.hit(damage);
            print(
              'Unit $id attacked unit ${targetUnit!.id} with $damage damage',
            );
          }
        }
      }
    }

    closestNode = nodes.atPosition(position);

    return result;
  }

  void hit(num attackPower) {
    health -= attackPower;
  }

  void destroy() {
    if (isHarvesting) {
      player.decreaseResourcesRate();
    }

    lockedNode?.unlock();
    lockedNode = null;
    targetNode = null;
    targetUnit = null;
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

  static String get newId => const Uuid().v4().substring(0, 16);

  @override
  bool operator ==(Object other) => other is Unit && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
