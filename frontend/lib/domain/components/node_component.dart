import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/json/json_position.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent extends PositionComponent {
  final JsonPosition jsonPosition;
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 5,
    color: Palette.NODE_HIGHLIGHT,
  );
  bool highlighted = false;

  NodeComponent({
    required super.position,
    required super.size,
    required this.jsonPosition,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.node.value,
       );

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  void highlight(bool value) {
    highlighted = value;
  }

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
