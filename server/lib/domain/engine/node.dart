import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/engine/position.dart';
import 'package:tensionpath/domain/engine/size.dart';
import 'package:tensionpath/domain/json/models/start/json_node.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/map_list.dart';

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

  static MapList<String, Node> list(List<JsonNode> nodes) {
    final MapList<String, Node> result = MapList();

    for (final JsonNode jsonNode in nodes) {
      final Node node = Node(
        id: jsonNode.location.id,
        type: jsonNode.type,
        location: Location.fromJson(jsonNode.location),
        position: _position(
          nodeSize: Constants.NODE_SIZE,
          location: Location.fromJson(jsonNode.location),
        ),
      );
      result.add(node.id, node);
    }

    return result;
  }

  static Position _position({
    required Size nodeSize,
    required Location location,
  }) => Position(
    x: nodeSize.width * ((location.y / 2) + location.x),
    y: nodeSize.height * 3 / 4 * location.y,
  );
}
