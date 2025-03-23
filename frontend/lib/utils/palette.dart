import 'package:flutter/material.dart';

class Palette {
  static const Color CONTROLS_BACKGROUND = Colors.green;

  static const Color CONTROLS_RESOURCES_BACKGROUND = Colors.orange;
  static const Color CONTROLS_RESOURCES_FOREGROUND = Colors.white;

  static const Color CONTROLS_CARD_BACKGROUND = Colors.grey;
  static const Color CONTROLS_CARD_FOREGROUND = Colors.orange;
  static const Color CONTROLS_CARD_VALUE = Colors.white;

  //---------------------------------------------------------------------------

  static const MaterialColor primary = Colors.blue;
  static const Color transparent = Colors.transparent;

  static const Color GAME_BACKGROUND = Colors.black;

  static const Color PLAYER_SELF = Colors.blue;
  static const Color PLAYER_ENEMY = Colors.red;
  static const Color PLAYER_NAME = Colors.white;

  static Color NODE_BORDER = Colors.white.withAlpha(80);
  static const Color NODE_LAND = Colors.green;
  static const Color NODE_MISSILE = Colors.brown;

  static Paint paint({
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
