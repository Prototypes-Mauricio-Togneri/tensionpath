import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class MovementPathComponent extends PositionComponent {
  final bool dashed;
  final Paint pathPaint = Palette.paint(
    style: PaintingStyle.stroke,
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
    pathPaint.color = color;
    pathPaint.strokeWidth = thickness;
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
      final Path path = Path();
      path.moveTo(positions[0].x, positions[0].y);

      for (int i = 1; i < positions.length; i++) {
        path.lineTo(positions[i].x, positions[i].y);
      }

      if (dashed) {
        canvas.drawPath(
          canvas.dashedPath(
            source: path,
            dashWidth: pathPaint.strokeWidth * 2,
            dashSpace: pathPaint.strokeWidth * 2,
          ),
          pathPaint,
        );
      } else {
        canvas.drawPath(path, pathPaint);
      }
    }
  }
}
