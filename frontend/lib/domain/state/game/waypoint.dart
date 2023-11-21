import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/node.dart';

class Waypoint {
  final String id;
  final Vector2 position;
  final Node? node;

  Waypoint({
    required this.id,
    required this.position,
    required this.node,
  });

  bool get hasNode => node != null;
}
