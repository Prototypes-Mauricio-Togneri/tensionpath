import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_shooter.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitShooterComponent<T extends UnitShooter> extends UnitComponent<T> {
  final Paint rangePaint = Paint();

  UnitShooterComponent({
    required super.unit,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    add(RectangleHitbox(
      isSolid: true,
    ));

    rangePaint.style = PaintingStyle.stroke;
    rangePaint.color = unit.color;
    rangePaint.strokeWidth = 0.5;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

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
