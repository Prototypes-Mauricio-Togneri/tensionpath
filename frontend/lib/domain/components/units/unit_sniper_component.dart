import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/units/unit_sniper.dart';
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
}
