import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class Lane {
  final String id;
  final Rect area;
  final List<Waypoint> waypoints;

  const Lane({
    required this.id,
    required this.area,
    required this.waypoints,
  });

  List<Node> get nodes =>
      waypoints.where((e) => e.hasNode).map((e) => e.node!).toList();

  Vector2 get position => area.topLeft.toVector2();

  Vector2 get size => Vector2(area.width, area.height);
}
