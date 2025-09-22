import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
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
    final List<Node> freeNodes = _nodes.list.where((n) => n.isFree).toList();

    for (final Node node in freeNodes) {
      final num distance = position.distanceTo(node.position);

      if (distance < closestDistance) {
        closestDistance = distance;
        result = node;
      }
    }

    return result;
  }
}
