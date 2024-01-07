import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit_specs.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends SpriteComponent with CollisionCallbacks {
  final UnitSpecs specs;
  final Player owner;
  final List<Waypoint> waypoints;
  late int nextWaypointIndex;
  late int power;

  UnitComponent({
    required this.specs,
    required this.owner,
    required this.waypoints,
    required Vector2 startingPosition,
    required super.size,
  }) : super(
          sprite: specs.sprite,
          anchor: Anchor.center,
          priority: Priority.unit.value,
        ) {
    power = specs.power;
    position = Vector2.copy(startingPosition);
    nextWaypointIndex = 0;
  }

  Waypoint get nextWaypoint => waypoints[nextWaypointIndex];

  @override
  FutureOr onLoad() {
    add(circleHitbox);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.moveToTarget(nextWaypoint.position, specs.speed * dt);
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

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) && owner.isSelf && other.owner.isEnemy) {
      if (power > other.power) {
        reducePower(other.power);
        other.destroy();
      } else if (power < other.power) {
        other.reducePower(power);
        destroy();
      } else {
        destroy();
        other.destroy();
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: power.toString(),
      position: size / 2,
      size: size.x / 3,
      color: Palette.white,
    );
  }
}
