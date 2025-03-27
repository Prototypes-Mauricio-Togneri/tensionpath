import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/units/unit_sniper.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitSniperComponent extends UnitComponent<UnitSniper> {
  final Paint fillPaint = Palette.paint(style: PaintingStyle.stroke);

  UnitSniperComponent({
    required super.unit,
    required super.position,
    required super.size,
  }) {
    fillPaint.color = unit.color;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, fillPaint);

    canvas.drawText(
      text: unit.health.toString(),
      position: size / 2,
      size: size.x / 3,
      color: Colors.white,
    );
  }
}
