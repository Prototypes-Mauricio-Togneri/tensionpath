import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class MovementPathComponent extends PositionComponent {
  final bool dashed;
  final Paint targetPaint = Palette.paint(
    style: PaintingStyle.fill,
    strokeCap: StrokeCap.round,
    strokeJoin: StrokeJoin.round,
  );
  List<Vector2> positions = [];

  MovementPathComponent({
    required super.position,
    required this.dashed,
    required Color color,
    required double thickness,
  }) : super(priority: Priority.path.value) {
    targetPaint.color = color;
    targetPaint.strokeWidth = thickness;
  }

  void show(List<Vector2> newPositions) {
    positions = newPositions;
  }

  void hide() {
    positions = [];
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (positions.length > 1) {
      if (dashed) {
        for (int i = 1; i < positions.length; i++) {
          canvas.drawDashedLine(
            start: positions[i - 1].toOffset(),
            end: positions[i].toOffset(),
            paint: targetPaint,
            dashSpacing: targetPaint.strokeWidth * 2,
            dashLength: targetPaint.strokeWidth * 2,
          );
        }
      } else {
        for (int i = 1; i < positions.length; i++) {
          canvas.drawLine(
            positions[i - 1].toOffset(),
            positions[i].toOffset(),
            targetPaint,
          );
        }
      }
    }
  }
}
