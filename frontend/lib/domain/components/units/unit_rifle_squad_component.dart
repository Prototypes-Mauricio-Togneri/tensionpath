import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/units/unit_rifle_squad.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitRifleSquadComponent extends UnitComponent<UnitRifleSquad> {
  final Paint fillPaint = Palette.paint(style: PaintingStyle.stroke);

  UnitRifleSquadComponent({
    required super.unit,
    required super.position,
    required super.size,
  }) {
    fillPaint.color = unit.color;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: unit.health.toString(),
      position: size / 2,
      size: size.x / 3,
      color: Colors.white,
    );
  }
}
