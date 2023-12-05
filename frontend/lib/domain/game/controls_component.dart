import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.topLeft,
          priority: Priority.battlefield.value,
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      BasicPalette.green.paint(),
    );

    for (int i = 0; i < 10; i++) {
      canvas.drawCircle(
        Offset((i * 75) + 100, 75),
        50,
        BasicPalette.red.paint(),
      );

      drawText(
        canvas: canvas,
        text: player.credits.toInt().toString(),
        position: size / 2,
        size: 50,
        color: Palette.white,
      );
    }
  }

  void drawText({
    required Canvas canvas,
    required String text,
    required Vector2 position,
    required double size,
    required Color color,
  }) {
    final TextStyle textStyle = TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.normal,
    );
    final TextSpan textSpan = TextSpan(
      text: (player.credits.toInt() + 7).toString(),
      style: textStyle,
    );
    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();

    final translatedPosition = translate(
      anchor: Anchor.center,
      point: Vector2(position.x, position.y),
      size: Vector2(textPainter.size.width, textPainter.size.height),
    );
    textPainter.paint(
      canvas,
      translatedPosition.toOffset(),
    );
  }

  Vector2 translate({
    required Anchor anchor,
    required Vector2 point,
    required Vector2 size,
  }) =>
      point - (Vector2(anchor.x, anchor.y)..multiply(size));
}
