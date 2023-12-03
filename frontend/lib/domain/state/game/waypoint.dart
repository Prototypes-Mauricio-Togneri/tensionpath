import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/unit.dart';

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

  bool isAligned(Unit unit) => (position - unit.position).length < 1;
}
