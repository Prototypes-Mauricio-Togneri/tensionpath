import 'dart:ui';

class Painter {
  static Paint create({
    PaintingStyle? style,
    Color? color,
    double? strokeWidth,
  }) {
    final Paint paint = Paint();

    if (color != null) {
      paint.color = color;
    }

    if (strokeWidth != null) {
      paint.strokeWidth = strokeWidth;
    }

    if (style != null) {
      paint.style = style;
    }

    return paint;
  }
}
