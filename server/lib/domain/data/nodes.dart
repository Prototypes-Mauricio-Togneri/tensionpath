import 'package:tensionpath/domain/data/resources.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Nodes {
  final IterableMap<String, Node> _nodes;

  const Nodes(this._nodes);

  Node get(String id) => _nodes.get(id);

  List<Node> get list => _nodes.list;

  Node atLocation(Location location) => get(location.id);

  Node atPosition(Position position) {
    final Node? result = closestFromList(
      position: position,
      availableNodes: _nodes.list,
    );

    if (result == null) {
      throw Exception('No closest node to position $position found');
    }

    return result;
  }

  Node? closestNodeToHarvest({
    required Resources resources,
    required Position position,
    required Node? lockedNode,
  }) {
    final List<Location> availableLocations = resources.list
        .where((r) => r.hasResources)
        .map((r) => r.location)
        .toList();
    final List<Node> availableNodes = _nodes.list
        .where(
          (n) =>
              availableLocations.contains(n.location) &&
              n.isFree &&
              (n.type == NodeType.resources) &&
              (n != lockedNode),
        )
        .toList();

    return closestFromList(
      position: position,
      availableNodes: availableNodes,
    );
  }

  Node? closestNodeToMove(Position position) {
    final List<Node> availableNodes = _nodes.list
        .where((n) => n.isFree && n.type.canMove)
        .toList();

    return closestFromList(
      position: position,
      availableNodes: availableNodes,
    );
  }

  Node? closestFromList({
    required Position position,
    required List<Node> availableNodes,
  }) {
    Node? result;
    num closestDistance = double.infinity;

    for (final Node node in availableNodes) {
      final num distance = position.distanceTo(node.position);

      if (distance < closestDistance) {
        closestDistance = distance;
        result = node;
      }
    }

    return result;
  }

  Node? closestAlternative({
    required Node node,
    required Unit unit,
  }) {
    final Node? upLeft = _nodes.getOrNull(
      '${node.location.x},${node.location.y - 1}',
    );
    final Node? upRight = _nodes.getOrNull(
      '${node.location.x + 1},${node.location.y - 1}',
    );
    final Node? right = _nodes.getOrNull(
      '${node.location.x + 1},${node.location.y}',
    );
    final Node? downRight = _nodes.getOrNull(
      '${node.location.x},${node.location.y + 1}',
    );
    final Node? downLeft = _nodes.getOrNull(
      '${node.location.x - 1},${node.location.y + 1}',
    );
    final Node? left = _nodes.getOrNull(
      '${node.location.x - 1},${node.location.y}',
    );

    final num distanceUpLeft = upLeft != null
        ? unit.position.distanceTo(upLeft.position)
        : double.infinity;
    final num distanceUpRight = upRight != null
        ? unit.position.distanceTo(upRight.position)
        : double.infinity;
    final num distanceRight = right != null
        ? unit.position.distanceTo(right.position)
        : double.infinity;
    final num distanceDownRight = downRight != null
        ? unit.position.distanceTo(downRight.position)
        : double.infinity;
    final num distanceDownLeft = downLeft != null
        ? unit.position.distanceTo(downLeft.position)
        : double.infinity;
    final num distanceLeft = left != null
        ? unit.position.distanceTo(left.position)
        : double.infinity;

    final num minDistance = [
      distanceUpLeft,
      distanceUpRight,
      distanceRight,
      distanceDownRight,
      distanceDownLeft,
      distanceLeft,
    ].reduce((a, b) => a < b ? a : b);

    if (minDistance == distanceUpLeft) {
      return upLeft;
    } else if (minDistance == distanceUpRight) {
      return upRight;
    } else if (minDistance == distanceRight) {
      return right;
    } else if (minDistance == distanceDownRight) {
      return downRight;
    } else if (minDistance == distanceDownLeft) {
      return downLeft;
    } else if (minDistance == distanceLeft) {
      return left;
    } else {
      return null;
    }
  }
}
