import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

extension CanvasExtension on Canvas {
  void drawText({
    required String text,
    required Vector2 position,
    required double size,
    TextAlign textAlign = TextAlign.center,
    Anchor anchor = Anchor.center,
    Color? color,
    Paint? foreground,
    Paint? background,
  }) {
    final TextStyle textStyle = TextStyle(
      fontSize: size,
      fontWeight: FontWeight.normal,
      color: color,
      foreground: foreground,
      background: background,
    );
    final TextSpan textSpan = TextSpan(text: text, style: textStyle);
    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
    );
    textPainter.layout();

    final Vector2 translatedPosition = translate(
      anchor: anchor,
      point: Vector2(position.x, position.y),
      size: Vector2(textPainter.size.width, textPainter.size.height),
    );
    textPainter.paint(this, translatedPosition.toOffset());
  }

  Vector2 translate({
    required Anchor anchor,
    required Vector2 point,
    required Vector2 size,
  }) => point - (Vector2(anchor.x, anchor.y)..multiply(size));

  void drawHexagon({
    required Vector2 size,
    Paint? fillPaint,
    Paint? borderPaint,
  }) {
    final Path hexagonPath = _createHexagonPath(size);

    if (fillPaint != null) {
      drawPath(hexagonPath, fillPaint);
    }

    if (borderPaint != null) {
      drawPath(hexagonPath, borderPaint);
    }
  }

  Path _createHexagonPath(Vector2 size) {
    final Path path = Path();
    final double width = size.x;
    final double height = size.y;
    final double centerX = width / 2;
    final double centerY = height / 2;
    final double radius = width / 2;

    for (int i = 0; i < 6; i++) {
      final double angle = (pi / 3) * i;
      final double x = centerX + radius * cos(angle);
      final double y = centerY + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    return path;
  }
}
