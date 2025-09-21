import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Nodes {
  final IterableMap<String, Node> _nodes;

  const Nodes(this._nodes);

  List<Node> get list => _nodes.list;

  Node atLocation(Location location) {
    for (final Node node in _nodes.list) {
      if (node.location == location) {
        return node;
      }
    }

    throw Exception('No node at location ${location.id}');
  }

  Node atPosition(Position position) {
    Node? closestNode;
    num closestDistance = double.infinity;

    for (final Node node in _nodes.list) {
      final num distance = position.distanceTo(node.position);

      if (distance < closestDistance) {
        closestDistance = distance;
        closestNode = node;
      }
    }

    if (closestNode == null) {
      throw Exception('No closest node to position $position found');
    }

    return closestNode;
  }
}
