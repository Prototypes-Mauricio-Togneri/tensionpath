import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_node_start.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class Node {
  final String id;
  final NodeType type;
  final Location location;
  final Position position;

  const Node({
    required this.id,
    required this.type,
    required this.location,
    required this.position,
  });

  static List<Node> list(List<JsonNodeStart> nodes) {
    final List<Node> result = [];

    for (final JsonNodeStart jsonNode in nodes) {
      final Node node = Node(
        id: jsonNode.location.id,
        type: jsonNode.type,
        location: Location.fromJson(jsonNode.location),
        position: Position.fromJson(jsonNode.position),
      );
      result.add(node);
    }

    return result;
  }
}
