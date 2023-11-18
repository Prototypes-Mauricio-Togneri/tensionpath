import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';

class Unit {
  final int power;
  final double speed;
  final List<Node> nodes;
  Node? lockedNode;
  Vector2 position;

  Unit._({
    required this.power,
    required this.speed,
    required this.nodes,
    required this.position,
  });

  void update(double dt) {
    if (lockedNode == null) {
      position.y -= speed * dt;
      _checkNodeLocking();
    }
  }

  void _checkNodeLocking() {
    for (final Node node in nodes) {
      if (node.isEmpty && node.isAligned(this)) {
        node.linkUnit(this);
        lockedNode = node;
        break;
      }
    }
  }

  factory Unit.create({
    required int commandPoints,
    required List<Node> nodes,
    required Lane lane,
  }) =>
      Unit._(
        power: commandPoints,
        speed: 200,
        nodes: nodes,
        position: Vector2(lane.position.x + 100, 3000),
      );
}
