import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/nodes.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Unit {
  final String id;
  final Player player;
  final UnitType type;
  final num radius;
  double health;
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
  });

  bool get isMoving => targetNode != null;

  void move(Node node) {
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
      } else if ((lockedNode == null) && (distanceToTarget < radius)) {
        print('Unit $id has locked the target node ${targetNode!.id}');
        // If the unit is inside of target node -> assign node to unit
        lockedNode = targetNode;
        lockedNode!.lock(this);
        result = true;
      }
    }

    /*if ((type == UnitType.harvester) &&
        (currentNodeType == NodeType.resources)) {
      player.addResources(dt * Constants.RESOURCES_PER_SECOND);
    }*/

    closestNode = nodes.atPosition(position);

    return result;
  }

  JsonUnitUpdate toJsonUpdate() => JsonUnitUpdate(
    id: id,
    playerIndex: player.index,
    type: type,
    health: health,
    currentPosition: position.toJson(),
    targetPosition: targetNode?.position.toJson(),
  );

  @override
  bool operator ==(Object other) => other is Unit && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
