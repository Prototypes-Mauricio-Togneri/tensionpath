import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';

class Unit {
  final double speed;
  final List<Node> nodes;
  int power;
  Node? lockedNode;
  Vector2 position;

  Unit._({
    required this.speed,
    required this.nodes,
    required this.power,
    required this.position,
  });

  void update(double dt) {
    if (lockedNode == null) {
      position.y -= speed * dt;
      _checkNodeLocking();
    }
  }

  void unlock() {
    lockedNode = null;
  }

  void merge(Unit unit) {
    power += unit.power;
  }

  void _checkNodeLocking() {
    for (final Node node in nodes) {
      if (node.isAligned(this)) {
        node.onUnitEnter(this);
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
