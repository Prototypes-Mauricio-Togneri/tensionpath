import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/utils/palette.dart';

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

  void drawUnitCircle({
    required Vector2 position,
    required Vector2 size,
    required Paint outterPaint,
    required Paint innerPaint,
    required int amount,
  }) {
    drawCircle(position.toOffset(), size.x / 4.5, outterPaint);
    drawCircle(position.toOffset(), size.x / 5.25, innerPaint);

    drawText(
      text: amount.toString(),
      color: Palette.UNIT_AMOUNT_INDICATOR,
      position: position,
      size: size.x / 6,
    );
  }

  void drawUnitHexagon({
    required Vector2 position,
    required Vector2 size,
    required Paint outterPaint,
    required Paint innerPaint,
    required int amount,
  }) {
    drawHexagon(center: position, size: size / 2, paint: outterPaint);
    drawHexagon(center: position, size: size / 2.35, paint: innerPaint);

    drawText(
      text: amount.toString(),
      color: Palette.UNIT_AMOUNT_INDICATOR,
      position: position,
      size: size.x / 6,
    );
  }

  void drawStructureHexagon({
    required Vector2 position,
    required Vector2 size,
    required Paint outterPaint,
    required Paint innerPaint,
  }) {
    drawHexagon(center: position, size: size, paint: outterPaint);
    drawHexagon(center: position, size: size * 0.9, paint: innerPaint);
  }

  void drawHexagon({
    required Vector2 center,
    required Vector2 size,
    required paint,
  }) {
    final Path hexagonPath = _createHexagonPath(center: center, size: size);
    drawPath(hexagonPath, paint);
  }

  Path _createHexagonPath({required Vector2 center, required Vector2 size}) {
    final Path path = Path();
    final double radius = size.x / 2;

    for (int i = 0; i < 6; i++) {
      final double angle = (pi / 3) * i;
      final double x = center.x + radius * cos(angle);
      final double y = center.y + radius * sin(angle);

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
