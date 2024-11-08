import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';

class BaseComponent extends PositionComponent with CollisionCallbacks {
  final Player player;
  final Paint backgroundPaint = Paint();
  final Paint foregroundPaint = Paint();

  BaseComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.base.value,
        );

  @override
  FutureOr onLoad() {
    add(RectangleHitbox());

    backgroundPaint.color = Colors.grey;
    foregroundPaint.color = player.color;

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) && (player != other.unit.owner)) {
      _onUnitCollided(other);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  void _onUnitCollided(UnitComponent unit) =>
      GameState.instance.onUnitCollidedWithBase(
        unit: unit,
        baseOwner: player,
      );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      backgroundPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width * (player.hp / 100), height),
      foregroundPaint,
    );

    canvas.drawText(
      text: player.id,
      position: size / 2,
      size: size.y / 2,
      color: Colors.white,
    );
  }
}
