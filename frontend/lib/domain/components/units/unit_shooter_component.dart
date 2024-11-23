import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_shooter.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitShooterComponent extends UnitComponent<UnitShooter> {
  final Paint backgroundPaint = Paint();
  final Paint rangePaint = Paint();

  UnitShooterComponent({
    required super.unit,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    add(CircleHitbox(
      isSolid: true,
    ));

    backgroundPaint.color = unit.color;

    rangePaint.style = PaintingStyle.stroke;
    rangePaint.color = unit.color;
    rangePaint.strokeWidth = 1;

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) &&
        unit.owner.isSelf &&
        other.unit.owner.isEnemy) {
      engine.onUnitsCollided(
        unit1: unit,
        unit2: other.unit,
      );
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
      text: '${unit.health}',
      position: size / 2,
      size: size.x / 3,
      color: Palette.UNIT_VALUE,
    );

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      unit.range,
      rangePaint,
    );
  }
}
