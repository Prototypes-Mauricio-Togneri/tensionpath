import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/unit.dart';

abstract class Node {
  final String id;
  final Lane lane;
  final Vector2 position;
  final Vector2 size;

  const Node({
    required this.id,
    required this.lane,
    required this.position,
    required this.size,
  });

  bool isAligned(Unit unit) => (position - unit.position).length < 1;

  NodeComponent get component;
}
