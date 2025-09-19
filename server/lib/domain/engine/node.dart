import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
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
    required List<JsonLocation> locations,
    required JsonMissile missile,
    required List<JsonResource> resources,
    required List<JsonLaunchers> launchers,
  }) {
    final MapList<String, Node> result = MapList();

    for (final JsonLocation jsonLocation in locations) {
      final Node node = Node(
        id: jsonLocation.id,
        type: _getNodeType(
          positionId: jsonLocation.id,
          missile: missile,
          resources: resources,
          launchers: launchers,
        ),
        location: Location.fromJson(jsonLocation),
      );
      result.add(node.id, node);
    }

    return result;
  }

  static NodeType _getNodeType({
    required String positionId,
    required JsonMissile missile,
    required List<JsonResource> resources,
    required List<JsonLaunchers> launchers,
  }) {
    if (missile.location.id == positionId) {
      return NodeType.missile;
    }

    final List<JsonLocation> padsPositions = missile.platforms
        .map((p) => p.pads)
        .expand((p) => p)
        .toList();

    if (padsPositions.any((pad) => pad.id == positionId)) {
      return NodeType.pad;
    }

    if (resources.any((resource) => resource.location.id == positionId)) {
      return NodeType.resources;
    }

    final List<JsonLocation> launchersPositions = launchers
        .map((launchers) => launchers.locations)
        .expand((locations) => locations)
        .toList();

    if (launchersPositions.any((launcher) => launcher.id == positionId)) {
      return NodeType.launcher;
    }

    return NodeType.empty;
  }
}
