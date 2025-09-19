import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/utils/map_list.dart';

class Node {
  final String id;
  final NodeType type;
  final Location location;

  const Node({
    required this.id,
    required this.type,
    required this.location,
  });

  static MapList<String, Node> list(List<JsonLocation> locations) {
    final MapList<String, Node> result = MapList();

    for (final JsonLocation jsonLocation in locations) {
      final Node node = Node(
        id: jsonLocation.id,
        type: NodeType.empty,
        location: Location(
          x: jsonLocation.x,
          y: jsonLocation.y,
        ),
      );
      result.add(node.id, node);
    }

    return result;
  }
}
