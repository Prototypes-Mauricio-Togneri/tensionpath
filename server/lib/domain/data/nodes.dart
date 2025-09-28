import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Nodes {
  final IterableMap<String, Node> _nodes;

  const Nodes(this._nodes);

  Node get(String id) => _nodes.get(id);

  List<Node> get list => _nodes.list;

  Node atLocation(Location location) => get(location.id);

  Node atPosition(Position position) {
    Node? result;
    num closestDistance = double.infinity;

    for (final Node node in _nodes.list) {
      final num distance = position.distanceTo(node.position);

      if (distance < closestDistance) {
        closestDistance = distance;
        result = node;
      }
    }

    if (result == null) {
      throw Exception('No closest node to position $position found');
    }

    return result;
  }

  Node? closestFreeNode(Position position) {
    Node? result;
    num closestDistance = double.infinity;
    final List<Node> availableNodes = _nodes.list
        .where((n) => n.isFree && n.type.canMove)
        .toList();

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
    final Node? upLeft = get('${node.location.x}-${node.location.y - 1}');
    final Node? upRight = get('${node.location.x + 1}-${node.location.y - 1}');
    final Node? right = get('${node.location.x + 1}-${node.location.y}');
    final Node? downRight = get('${node.location.x}-${node.location.y + 1}');
    final Node? downLeft = get('${node.location.x - 1}-${node.location.y + 1}');
    final Node? left = get('${node.location.x - 1}-${node.location.y}');

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
