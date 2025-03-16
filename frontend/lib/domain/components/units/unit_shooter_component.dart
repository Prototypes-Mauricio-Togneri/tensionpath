import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_shooter.dart';

class UnitShooterComponent<T extends UnitShooter> extends UnitComponent<T> {
  final Paint rangePaint = Paint();

  UnitShooterComponent({required super.unit, required super.size});

  @override
  FutureOr onLoad() {
    add(RectangleHitbox(isSolid: true));

    rangePaint.style = PaintingStyle.stroke;
    rangePaint.color = unit.color;
    rangePaint.strokeWidth = 0.5;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), unit.range, rangePaint);

    super.render(canvas);
  }
}
