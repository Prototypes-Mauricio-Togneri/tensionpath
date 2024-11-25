import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_ranger.dart';

class UnitRangerComponent extends UnitShooterComponent<UnitRanger> {
  final Paint backgroundPaint = Paint();

  UnitRangerComponent({
    required super.unit,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    backgroundPaint.color = unit.color;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      backgroundPaint,
    );

    super.render(canvas);
  }
}
