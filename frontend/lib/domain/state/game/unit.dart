import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class Unit {
  final Player owner;
  final World world;
  final double speed;
  final List<Waypoint> waypoints;
  late Vector2 position;
  late int nextWaypointIndex;
  int power;

  Unit._({
    required this.owner,
    required this.world,
    required this.power,
    required this.speed,
    required this.waypoints,
    required Vector2 startingPosition,
  }) {
    position = Vector2.copy(startingPosition);
    nextWaypointIndex = 0;
  }

  Sprite get sprite => owner.unitSprite;

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
    _checkNextWaypoint();
  }

  void _checkNextWaypoint() {
    if (nextWaypoint.isAligned(this) &&
        (nextWaypointIndex < (waypoints.length - 1))) {
      nextWaypointIndex++;
    }
  }

  void reducePower(int value) {
    power -= value;
  }

  void destroy() {
    world.remove(component);
  }

  factory Unit.create({
    required Player owner,
    required World world,
    required int power,
    required List<Waypoint> waypoints,
  }) =>
      Unit._(
        owner: owner,
        world: world,
        power: power,
        speed: Constants.UNIT_SPEED,
        startingPosition: waypoints.first.position,
        waypoints: waypoints.sublist(1, waypoints.length),
      );
}
