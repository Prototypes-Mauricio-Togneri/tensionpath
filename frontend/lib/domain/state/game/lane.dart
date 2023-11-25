import 'package:tensionpath/domain/state/game/node.dart';
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

  List<Waypoint> getWaypoints(bool forward) {
    if (forward) {
      return waypoints.sublist(1, waypoints.length);
    } else {
      return waypoints.sublist(0, waypoints.length - 1).reversed.toList();
    }
  }
}
