import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/start/json_node.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
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

  static MapList<String, Node> list({
    required List<JsonNode> nodes,
    required JsonMissile missile,
    required List<JsonResource> resources,
    required List<JsonLaunchers> launchers,
  }) {
    final MapList<String, Node> result = MapList();

    for (final JsonNode jsonNode in nodes) {
      final Node node = Node(
        id: jsonNode.location.id,
        type: jsonNode.type,
        location: Location.fromJson(jsonNode.location),
      );
      result.add(node.id, node);
    }

    return result;
  }
}
