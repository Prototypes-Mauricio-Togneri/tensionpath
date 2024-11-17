import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef {
  final Unit unit;
  final Paint backgroundPaint = Paint();

  UnitComponent({
    required this.unit,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.unit.value,
        ) {
    position = unit.position;
  }

  @override
  FutureOr onLoad() {
    add(CircleHitbox());

    backgroundPaint.color = unit.color;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.setFrom(unit.position);
  }

  // TODO(momo): move destroy logic to engine
  void destroy() {
    unit.destroy();
    gameRef.world.remove(this);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) &&
        unit.owner.isSelf &&
        other.unit.owner.isEnemy) {
      if (unit.hp > other.unit.hp) {
        unit.reduceHealth(other.unit.hp);
        other.destroy();
      } else if (unit.hp < other.unit.hp) {
        other.unit.reduceHealth(unit.hp);
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

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      backgroundPaint,
    );

    canvas.drawText(
      text: unit.hp.toString(),
      position: size / 2,
      size: size.x / 3,
      color: Palette.UNIT_VALUE,
    );
  }
}
