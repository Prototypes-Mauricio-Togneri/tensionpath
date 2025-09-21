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
    lockedNode = null;
  }

  bool update({
    required double dt,
    required Nodes nodes,
  }) {
    bool result = false;

    if (isMoving) {
      /*if (targetNode!.notLockedBy(this)) {
        // Re-assign node
        targetNode = null; // TODO(momo): implement
        result = true;
      }*/

      // Update position
      position.moveTowards(
        target: targetNode!.position,
        distance: type.speed * dt,
      );

      final num distanceToTarget = position.distanceTo(targetNode!.position);
      print(
        'New unit position $position. Remaining distance: $distanceToTarget',
      );

      if (distanceToTarget < (type.speed * 5)) {
        print('Unit $id has arrived to the target node ${targetNode!.id}');
        // If the unit has arrived to the target node -> stop moving
        position = targetNode!.position;
        targetNode = null;
        result = true;
      } else if ((lockedNode == null) && (distanceToTarget < radius)) {
        print('Unit $id has locked the target node ${targetNode!.id}');
        // If the unit is inside of target node -> assign node to unit
        lockedNode = targetNode;
        targetNode!.lock(this);
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
