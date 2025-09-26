import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class MovementPathComponent extends Component {
  final Paint targetPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  Vector2? startPosition;
  Vector2? endPosition;

  MovementPathComponent({
    required Color color,
    required double thickness,
  }) {
    targetPaint.color = color;
    targetPaint.strokeWidth = thickness;
  }

  void show({
    required Vector2 start,
    required Vector2 end,
  }) {
    startPosition = start;
    endPosition = end;
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
        start: startPosition!.toOffset(),
        end: endPosition!.toOffset(),
        paint: targetPaint,
        dashSpacing: targetPaint.strokeWidth * 1,
        dashLength: targetPaint.strokeWidth * 2,
      );
    }
  }
}
