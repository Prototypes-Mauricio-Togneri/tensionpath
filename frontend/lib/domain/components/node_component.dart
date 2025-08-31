import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent extends PositionComponent {
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 5,
    color: Palette.NODE_HIGHLIGHT,
  );
  bool highlighted = false;

  NodeComponent({
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.node.value,
       );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (highlighted) {
      canvas.drawHexagon(
        center: size / 2,
        size: size,
        borderPaint: borderPaint,
      );
    }
  }
}
