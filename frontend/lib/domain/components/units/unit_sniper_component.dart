import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_sniper.dart';

class UnitSniperComponent extends UnitShooterComponent<UnitSniper> {
  final Paint borderPaint = Paint();

  UnitSniperComponent({required super.unit, required super.size});

  @override
  FutureOr onLoad() {
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.color = unit.color;
    borderPaint.strokeWidth = size.y / 12;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(width / 2, height / 2),
        width: width * 0.5,
        height: height,
      ),
      borderPaint,
    );

    canvas.drawLine(
      Offset(width / 2, height * 0.75),
      Offset(width / 2, 0),
      borderPaint,
    );

    super.render(canvas);
  }
}
