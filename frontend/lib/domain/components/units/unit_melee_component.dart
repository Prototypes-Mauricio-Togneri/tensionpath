import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_melee.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitMeleeComponent extends UnitComponent<UnitMelee> {
  final Paint backgroundPaint = Paint();

  UnitMeleeComponent({
    required super.unit,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    add(CircleHitbox(
      isSolid: true,
    ));

    backgroundPaint.color = unit.color;

    return super.onLoad();
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
      text: unit.health.toString(),
      position: size / 2,
      size: size.x / 3,
      color: Palette.UNIT_VALUE,
    );
  }
}
