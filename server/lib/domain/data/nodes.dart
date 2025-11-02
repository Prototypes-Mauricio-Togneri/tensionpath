import 'package:tensionpath/domain/data/resources.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_node_start.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/utils/iterable_map.dart';

// Helper class for A* pathfinding
class _PathNode {
  final Node node;
  final num fScore;

  const _PathNode(this.node, this.fScore);
}

class Nodes {
  final IterableMap<String, Node> _nodes;

  const Nodes(this._nodes);

  Node get(String id) => _nodes.get(id);

  List<Node> get list => _nodes.list;

  Node atLocation(Location location) => get(location.id);

  Node atPosition(Position position) {
    final Node? result = _closestFromList(
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

    return _closestFromList(
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

    return _closestFromList(
      position: position,
      availableNodes: availableNodes,
    );
  }

  Node? _closestFromList({
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

  // A* pathfinding algorithm
  List<Node> path({
    required Unit unit,
    required Node from,
    required Node to,
  }) {
    if (from == to) {
      return [to];
    }

    // Priority queue for open set (nodes to explore)
    final List<_PathNode> openSet = [];
    // Set of already evaluated nodes
    final Set<Node> closedSet = {};
    // Map to track came from relationships
    final Map<Node, Node> cameFrom = {};
    // Cost from start to each node
    final Map<Node, num> gScore = {from: 0};
    // Estimated total cost from start to goal through each node
    final Map<Node, num> fScore = {from: _heuristic(from, to)};

    // Add starting node to open set
    openSet.add(_PathNode(from, fScore[from]!));

    while (openSet.isNotEmpty) {
      // Get node with lowest fScore
      openSet.sort((a, b) => a.fScore.compareTo(b.fScore));
      final _PathNode current = openSet.removeAt(0);
      final Node currentNode = current.node;

      // If we reached the goal, reconstruct path
      if (currentNode == to) {
        return _reconstructPath(cameFrom, currentNode);
      }

      closedSet.add(currentNode);

      // Explore neighbors
      for (final Node neighbor in currentNode.neighbors) {
        if (closedSet.contains(neighbor)) {
          continue; // Already evaluated
        }

        // Calculate tentative gScore including node cost
        final num tentativeGScore =
            gScore[currentNode]! +
            _distance(currentNode, neighbor) +
            neighbor.movementCost(unit);

        // If this path to neighbor is better than any previous one
        if (!gScore.containsKey(neighbor) ||
            tentativeGScore < gScore[neighbor]!) {
          // Record this path
          cameFrom[neighbor] = currentNode;
          gScore[neighbor] = tentativeGScore;
          fScore[neighbor] = tentativeGScore + _heuristic(neighbor, to);

          // Add to open set if not already there
          if (!openSet.any((pathNode) => pathNode.node == neighbor)) {
            openSet.add(_PathNode(neighbor, fScore[neighbor]!));
          }
        }
      }
    }

    // No path found
    return [];
  }

  // Heuristic function (Euclidean distance)
  num _heuristic(Node a, Node b) => a.position.distanceTo(b.position);

  // Distance between two adjacent nodes
  num _distance(Node a, Node b) => a.position.distanceTo(b.position);

  // Reconstruct path from cameFrom map
  List<Node> _reconstructPath(Map<Node, Node> cameFrom, Node current) {
    Node currentNode = current;
    final List<Node> totalPath = [currentNode];

    while (cameFrom.containsKey(currentNode)) {
      currentNode = cameFrom[currentNode]!;
      totalPath.insert(0, currentNode);
    }

    return totalPath.sublist(1);
  }

  factory Nodes.load(List<JsonNodeStart> nodes) {
    final IterableMap<String, Node> result = IterableMap();

    for (final JsonNodeStart jsonNode in nodes) {
      final Node node = Node(
        id: jsonNode.location.id,
        type: jsonNode.type,
        location: Location.fromJson(jsonNode.location),
        position: Position.fromJson(jsonNode.position),
      );
      result.add(node.id, node);
    }

    for (final Node node in result.list) {
      for (final Location location in node.location.neighborLocations) {
        try {
          final Node neighborNode = result.get(location.id);
          node.neighbors.add(neighborNode);
        } catch (_) {
          // Neighbor node not found, ignore
        }
      }
    }

    return Nodes(result);
  }
}
