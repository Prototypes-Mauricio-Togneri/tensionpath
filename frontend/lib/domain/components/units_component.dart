import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';

class UnitsComponent extends PositionComponent {
  final Units units;
  final Node node;

  UnitsComponent({
    required this.units,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  @override
  void render(Canvas canvas) {
    final Paint paintOutter =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle((size / 2).toOffset(), size.x / 3, paintOutter);

    final Paint paintInner =
        Paint()
          ..color = units.player.color
          ..style = PaintingStyle.fill;

    canvas.drawCircle((size / 2).toOffset(), size.x / 3.2, paintInner);

    canvas.drawText(
      text: units.amount.toString(),
      color: Colors.white,
      position: size / 2,
      size: size.x / 4,
    );
  }
}
