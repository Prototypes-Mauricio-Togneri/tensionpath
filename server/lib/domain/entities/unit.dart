import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/nodes.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Unit {
  final String id;
  final Player player;
  final UnitType type;
  final num radius;
  num health;
  Position position;
  Node closestNode;
  Node? targetNode;
  Node? lockedNode;

  Unit({
    required this.id,
    required this.player,
    required this.type,
    required this.radius,
    required this.closestNode,
    required this.position,
    required this.health,
  }) {
    lockedNode = closestNode;
  }

  bool get isMoving => targetNode != null;

  bool get isHarvesting =>
      (type == UnitType.harvester) &&
      (lockedNode != null) &&
      (lockedNode!.type == NodeType.resources);

  void move(Node node) {
    if (isHarvesting) {
      player.increaseResourcesRate();
    }

    targetNode = node;
    lockedNode?.unlock();
    lockedNode = null;
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
    }
    closestNode = nodes.atPosition(position);

    return result;
  }

  void destroy() {
    lockedNode?.unlock();
    lockedNode = null;
    targetNode = null;
  }

  JsonUnitUpdate toJsonUpdate() => JsonUnitUpdate(
    id: id,
    playerIndex: player.index,
    type: type,
    health: health,
    currentPosition: position.toJson(),
    targetPosition: targetNode?.position.toJson(),
    lockedLocation: lockedNode?.location.toJson(),
  );

  @override
  bool operator ==(Object other) => other is Unit && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
