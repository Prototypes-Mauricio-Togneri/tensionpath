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

  Node? closestNodeToMove({
    required Position position,
    required Unit unit,
  }) {
    final List<Node> availableNodes = _nodes.list
        .where((n) => n.canMove(unit))
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

  // TODO: implement
  List<Node> path({
    required Node from,
    required Node to,
  }) {
    return [to];
  }
}
