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
}
