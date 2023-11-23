import 'package:flame/components.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class Unit {
  final World world;
  final double speed;
  final List<Waypoint> waypoints;
  late Vector2 position;
  late int nextWaypointIndex;
  int power;

  Unit._({
    required this.world,
    required this.speed,
    required this.waypoints,
    required this.power,
  }) {
    position = Vector2.copy(waypoints[0].position);
    nextWaypointIndex = 1;
  }

  Waypoint get nextWaypoint => waypoints[nextWaypointIndex];

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
    position.moveToTarget(nextWaypoint.position, speed * dt);
    _checkNodeLocking();
  }

  void merge(Unit unit) {
    power += unit.power;
    component.refresh();
  }

  void _checkNodeLocking() {
    if (nextWaypoint.isAligned(this) &&
        (nextWaypointIndex < (waypoints.length - 1))) {
      nextWaypointIndex++;
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
        waypoints: lane.waypoints,
      );
}
