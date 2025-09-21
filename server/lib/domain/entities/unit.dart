import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Unit {
  final String id;
  final Player player;
  final UnitType type;
  Node closestNode;
  Node? targetNode;
  Node? lockedNode;
  Position position;
  double health;

  Unit({
    required this.id,
    required this.player,
    required this.type,
    required this.closestNode,
    required this.position,
    required this.health,
  });

  bool get isMoving => targetNode != null;

  void move(Node node) {
    targetNode = node;
    lockedNode = null;
  }

  bool update(double dt) {
    /*
      - If moving
        - If target node is free
          - Update position
          - If unit inside of target node -> assign node to unit
        - If target node is not free
          - Re-assign node
          - Update position
          - If unit inside of target node -> assign node to unit
    */

    /*if ((type == UnitType.harvester) &&
        (currentNodeType == NodeType.resources)) {
      player.addResources(dt * Constants.RESOURCES_PER_SECOND);
    }*/

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
