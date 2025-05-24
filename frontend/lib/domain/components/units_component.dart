import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitsComponent extends PositionComponent {
  final Units units;
  final Node node;
  final Paint paintOutter = Palette.paint(style: PaintingStyle.fill);
  final Paint paintInner = Palette.paint(style: PaintingStyle.fill);

  UnitsComponent({
    required this.units,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value) {
    paintOutter.color = units.player.color.darken(0.5);
    paintInner.color = units.player.color;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle((size / 2).toOffset(), size.x / 3, paintOutter);
    canvas.drawCircle((size / 2).toOffset(), size.x / 3.2, paintInner);

    canvas.drawText(
      text: units.amount.toString(),
      color: Palette.UNIT_INDICATOR,
      position: size / 2,
      size: size.x / 4,
    );
  }
}
