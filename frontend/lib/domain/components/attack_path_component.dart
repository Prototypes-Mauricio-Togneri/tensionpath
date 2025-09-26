import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/utils/palette.dart';

class AttackPathComponent extends Component {
  final Paint targetPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  Offset? startPosition;
  Offset? endPosition;

  AttackPathComponent({
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
      canvas.drawLine(
        startPosition!,
        endPosition!,
        targetPaint,
      );
    }
  }
}
