import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_ranger.dart';

class UnitRangerComponent extends UnitShooterComponent<UnitRanger> {
  final Paint borderPaint = Paint();

  UnitRangerComponent({required super.unit, required super.size});

  @override
  FutureOr onLoad() {
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.color = unit.color;
    borderPaint.strokeWidth = size.y / 12;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderPaint);

    canvas.drawLine(
      Offset(width / 2, height / 2),
      Offset(width / 2, 0),
      borderPaint,
    );

    super.render(canvas);
  }
}
