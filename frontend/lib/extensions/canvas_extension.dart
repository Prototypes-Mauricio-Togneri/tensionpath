import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
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
    double angle = 0,
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

    final Vector2 textSize = Vector2(
      textPainter.size.width,
      textPainter.size.height,
    );

    final Vector2 translatedPosition = translatePosition(
      anchor: anchor,
      point: Vector2(position.x, position.y),
      size: textSize,
    );

    if (angle == 0) {
      textPainter.paint(this, translatedPosition.toOffset());
    } else {
      // Save the canvas state
      save();

      // Move the canvas to the center of the text
      translate(
        translatedPosition.x + textSize.x / 2,
        translatedPosition.y + textSize.y / 2,
      );

      // Rotate 180 degrees (π radians)
      rotate(pi);

      // Move the origin back by half the size so text is centered
      translate(-textSize.x / 2, -textSize.y / 2);

      // Paint the text at the new origin
      textPainter.paint(this, Offset.zero);

      // Restore the canvas state
      restore();
    }
  }

  Vector2 translatePosition({
    required Anchor anchor,
    required Vector2 point,
    required Vector2 size,
  }) => point - (Vector2(anchor.x, anchor.y)..multiply(size));

  void drawUnitCircle({
    required Player player,
    required Vector2 position,
    required Vector2 size,
    required Paint outterPaint,
    required Paint innerPaint,
    required int level,
    required UnitType type,
    required double angle,
  }) {
    drawCircle(position.toOffset(), size.x / 3.5, outterPaint);
    drawCircle(position.toOffset(), size.x / 4, innerPaint);

    final double offset = size.y / 8;

    drawText(
      text: type.emoji,
      color: Palette.UNIT_LEVEL_INDICATOR,
      position: Vector2(
        position.x,
        position.y + (player.isPlayer1 ? -offset : offset),
      ),
      size: size.x / 6,
      angle: angle,
    );

    drawText(
      text: level.toString(),
      color: Palette.UNIT_LEVEL_INDICATOR,
      position: Vector2(
        position.x,
        position.y + (player.isPlayer1 ? offset : -offset),
      ),
      size: size.x / 6,
      angle: angle,
    );
  }

  void drawUnitHexagon({
    required Vector2 position,
    required Vector2 size,
    required Paint outterPaint,
    required Paint innerPaint,
    required int level,
    required UnitType type,
  }) {
    drawHexagon(center: position, size: size / 1.5, paint: outterPaint);
    drawHexagon(center: position, size: size / 1.72, paint: innerPaint);

    drawText(
      text: type.emoji,
      color: Palette.UNIT_LEVEL_INDICATOR,
      position: Vector2(position.x, position.y - (size.y / 8)),
      size: size.x / 6,
    );

    drawText(
      text: level.toString(),
      color: Palette.UNIT_LEVEL_INDICATOR,
      position: Vector2(position.x, position.y + (size.y / 8)),
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

  void drawHighlightHexagon({
    required Vector2 position,
    required Vector2 size,
    required Paint paint,
  }) {
    paint.strokeWidth = size.x * 0.05;
    drawHexagon(center: position, size: size * 0.9, paint: paint);
  }

  void drawHexagon({
    required Vector2 center,
    required Vector2 size,
    required Paint paint,
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

  void movementLine({
    required Vector2 origin,
    required Vector2 target,
    required double radius,
    required Paint paint,
    required bool moving,
  }) {
    final double distance = origin.distanceTo(target);
    final double threshold = radius / 4.5;
    paint.strokeWidth = radius / 20;

    if (distance >= threshold) {
      final Vector2 originPoint = _moveTowards(
        origin: origin,
        target: target,
        distance: threshold,
      );
      final Vector2 targetPoint2 = _moveTowards(
        origin: target,
        target: origin,
        distance: moving ? 0 : threshold + 10,
      );

      paint.style = PaintingStyle.stroke;
      drawLine(originPoint.toOffset(), targetPoint2.toOffset(), paint);

      // --- Draw arrowhead as a triangle at the end (targetPoint) ---
      final Vector2 arrowTip = _moveTowards(
        origin: target,
        target: origin,
        distance: moving ? -10 : threshold,
      );
      const double arrowLength = 20;
      const double arrowAngle = pi / 7; // Angle between arrow sides

      final Vector2 direction = (originPoint - arrowTip).normalized();
      final double angle = atan2(direction.y, direction.x);

      // Calculate the three points of the triangle
      final Vector2 left =
          arrowTip +
          Vector2(
            arrowLength * cos(angle + arrowAngle),
            arrowLength * sin(angle + arrowAngle),
          );
      final Vector2 right =
          arrowTip +
          Vector2(
            arrowLength * cos(angle - arrowAngle),
            arrowLength * sin(angle - arrowAngle),
          );

      final Path arrowHead = Path()
        ..moveTo(arrowTip.x, arrowTip.y)
        ..lineTo(left.x, left.y)
        ..lineTo(right.x, right.y)
        ..close();

      paint.style = PaintingStyle.fill;
      drawPath(arrowHead, paint);
    }
  }

  Vector2 _moveTowards({
    required Vector2 origin,
    required Vector2 target,
    required double distance,
  }) {
    final Vector2 direction = target - origin;

    if (direction.length == 0) {
      return origin;
    } else {
      return origin + direction.normalized() * distance;
    }
  }
}
