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
  Node closestNode;
  Node? targetNode;
  Node? lockedNode;
  Position position;
  double health;

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
    if (isMoving) {
      if (targetNode!.notLockedBy(this)) {
        // Re-assign node
        targetNode = null; // TODO(momo): implement
      }

      // Update position
      position.moveTowards(
        target: targetNode!.position,
        distance: type.speed * dt,
      );

      // If unit inside of target node -> assign node to unit
      if (position.distanceTo(targetNode!.position) < radius) {
        lockedNode = targetNode;
        targetNode!.lock(this);
      }
    }

    /*if ((type == UnitType.harvester) &&
        (currentNodeType == NodeType.resources)) {
      player.addResources(dt * Constants.RESOURCES_PER_SECOND);
    }*/

    closestNode = nodes.atPosition(position);

    return false;
  }

  JsonUnitUpdate toJsonUpdate() => JsonUnitUpdate(
    id: id,
    playerIndex: player.index,
    type: type,
    location: closestNode.location.toJson(),
    position: position.toJson(),
    health: health,
  );

  @override
  bool operator ==(Object other) => other is Unit && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
