import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

extension CanvasExtension on Canvas {
  void drawText({
    required String text,
    required Vector2 position,
    required double size,
    TextAlign textAlign = TextAlign.center,
    FontWeight fontWeight = FontWeight.normal,
    Anchor anchor = Anchor.center,
    Color? color,
    Paint? foreground,
    Paint? background,
  }) {
    final TextStyle textStyle = TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
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

  void drawHexagon({
    required Vector2 center,
    required Vector2 size,
    Paint? fillPaint,
    Paint? borderPaint,
  }) {
    if (fillPaint != null) {
      final Path hexagonPath = _createHexagonPath(
        center: center,
        size: size,
      );
      drawPath(hexagonPath, fillPaint);
    }

    if (borderPaint != null) {
      borderPaint.strokeWidth = size.x * 0.04;
      final double borderSizeRatio = 1 - (borderPaint.strokeWidth / size.x);
      final Path hexagonPath = _createHexagonPath(
        center: center,
        size: size * borderSizeRatio,
      );
      drawPath(hexagonPath, borderPaint);
    }
  }

  Path _createHexagonPath({
    required Vector2 center,
    required Vector2 size,
  }) {
    final Path path = Path();
    final double radius = min(size.x, size.y) / 2;

    for (int i = 0; i < 6; i++) {
      final double angle = (pi / 6) + (pi / 3) * i;
      final double x = center.x + radius * 1.15 * cos(angle);
      final double y = center.y + radius * 1.15 * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    return path;
  }

  Vector2 translate({
    required Anchor anchor,
    required Vector2 point,
    required Vector2 size,
  }) => point - (Vector2(anchor.x, anchor.y)..multiply(size));

  Path dashedPath({
    required Path source,
    required double dashWidth,
    required double dashSpace,
  }) {
    final Path result = Path();

    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final double nextDistance = distance + dashWidth;
        result.addPath(
          metric.extractPath(distance, nextDistance.clamp(0, metric.length)),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    return result;
  }
}
