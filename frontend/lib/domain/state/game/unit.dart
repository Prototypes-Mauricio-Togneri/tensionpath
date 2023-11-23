import 'package:flame/components.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class Unit {
  final World world;
  final double speed;
  final List<Waypoint> waypoints;
  late Waypoint nextWaypoint;
  late Vector2 position;
  int power;
  Node? lockedNode;

  Unit._({
    required this.world,
    required this.speed,
    required this.waypoints,
    required this.power,
  }) {
    position = waypoints[0].position;
    nextWaypoint = waypoints[1];
  }

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
      position.moveToTarget(nextWaypoint.position, speed * dt);
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
    /*for (final Node node in nodes) {
      if (node.isAligned(this)) {
        node.onUnitEnter(this);
        lockedNode = node;
        break;
      }
    }*/
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
        waypoints: lane.waypoints,
      );
}
