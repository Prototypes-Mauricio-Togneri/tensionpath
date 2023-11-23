import 'package:flame/components.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';

class Unit {
  final World world;
  final double speed;
  final List<Node> nodes;
  int power;
  Node? lockedNode;
  Vector2 position;

  Unit._({
    required this.world,
    required this.speed,
    required this.nodes,
    required this.power,
    required this.position,
  });

  UnitComponent get component {
    final List<UnitComponent> unitComponents =
        world.children.query<UnitComponent>();

    for (final UnitComponent component in unitComponents) {
      if (component.unit == this) {
        return component;
      }
    }

    throw Exception('Associated component not found');
  }

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
    component.refresh();
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

  void destroy() {
    world.remove(component);
  }

  factory Unit.create({
    required World world,
    required int commandPoints,
    required Lane lane,
  }) =>
      Unit._(
        world: world,
        power: commandPoints,
        speed: 200,
        nodes: lane.nodes,
        position: Vector2(lane.position.x + 100, 3000),
      );
}
