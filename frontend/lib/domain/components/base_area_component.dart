import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/state/game/base.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/types/priority.dart';

class BaseAreaComponent extends PositionComponent with CollisionCallbacks {
  final Base base;

  BaseAreaComponent({
    required this.base,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.base.value,
        );

  @override
  FutureOr onLoad() {
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) && (base.player != other.unit.owner)) {
      _onUnitCollided(other);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  void _onUnitCollided(UnitComponent unit) =>
      GameState.instance.onUnitCollidedWithBase(
        unit: unit,
        base: base,
      );
}
