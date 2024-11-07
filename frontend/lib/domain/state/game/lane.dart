import 'package:tensionpath/domain/state/game/waypoint.dart';

class Lane {
  final String id;
  final List<Waypoint> waypoints;

  const Lane({
    required this.id,
    required this.waypoints,
  });

  List<Waypoint> getWaypointsFrom({
    required Waypoint fromWaypoint,
    required bool forward,
  }) {
    final List<Waypoint> list =
        forward ? waypoints : waypoints.reversed.toList();
    final List<Waypoint> result = [];
    bool found = false;

    for (final Waypoint waypoint in list) {
      if (waypoint == fromWaypoint) {
        found = true;
      }

      if (found) {
        result.add(waypoint);
      }
    }

    return result;
  }
}
