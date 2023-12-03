import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class Lane {
  final String id;
  final List<Waypoint> waypoints;

  const Lane({
    required this.id,
    required this.waypoints,
  });

  List<Node> get nodes =>
      waypoints.where((e) => e.hasNode).map((e) => e.node!).toList();

  List<Waypoint> getWaypointsFrom({
    required Node node,
    required bool forward,
  }) {
    final List<Waypoint> list =
        forward ? waypoints : waypoints.reversed.toList();
    final List<Waypoint> result = [];
    bool found = false;

    for (final Waypoint waypoint in list) {
      if (waypoint.node == node) {
        found = true;
      }

      if (found) {
        result.add(waypoint);
      }
    }

    return result;
  }
}
