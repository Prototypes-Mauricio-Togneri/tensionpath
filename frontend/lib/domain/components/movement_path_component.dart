import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class MovementPathComponent extends PositionComponent {
  final Paint targetPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  Offset? startPosition;
  Offset? endPosition;

  MovementPathComponent({
    required super.position,
    required Color color,
    required double thickness,
  }) : super(priority: Priority.path.value) {
    targetPaint.color = color;
    targetPaint.strokeWidth = thickness;
  }

  void show({
    required Vector2 start,
    required Vector2 end,
  }) {
    startPosition = start.toOffset();
    endPosition = end.toOffset();
  }

  void hide() {
    startPosition = null;
    endPosition = null;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if ((startPosition != null) && (endPosition != null)) {
      canvas.drawDashedLine(
        start: startPosition!,
        end: endPosition!,
        paint: targetPaint,
        dashSpacing: targetPaint.strokeWidth * 1,
        dashLength: targetPaint.strokeWidth * 2,
      );
    }
  }
}
