import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class Unit {
  final Player owner;
  final double speed;
  final List<Waypoint> waypoints;
  late Vector2 position;
  late int nextWaypointIndex;
  int power;

  Unit._({
    required this.owner,
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
    GameState.instance.destroyUnit(this);
  }

  factory Unit.create({
    required Player owner,
    required int power,
    required List<Waypoint> waypoints,
  }) =>
      Unit._(
        owner: owner,
        power: power,
        speed: Constants.UNIT_SPEED,
        startingPosition: waypoints.first.position,
        waypoints: waypoints.sublist(1, waypoints.length),
      );
}
