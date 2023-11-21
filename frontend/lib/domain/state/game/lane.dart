import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class Lane {
  final String id;
  final Vector2 position;
  final Vector2 size;
  final List<Waypoint> waypoints;

  const Lane({
    required this.id,
    required this.position,
    required this.size,
    required this.waypoints,
  });
}
