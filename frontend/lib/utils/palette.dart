import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primary = Colors.blue;
  static const Color transparent = Colors.transparent;

  static const Color GAME_BACKGROUND = Colors.black;

  static const Color PLAYER_1 = Colors.blue;
  static const Color PLAYER_2 = Colors.red;

  static const Color HEADER_PLAYER_NAME = Colors.white;
  static const Color HEADER_BACKGROUND = Colors.grey;

  static const Color CONTROLS_UNIT_TEXT = Colors.white;
  static const Color CONTROLS_RESOURCES_BACKGROUND = Colors.orange;
  static const Color CONTROLS_RESOURCES_FOREGROUND = Colors.white;
  static const Color CONTROLS_BACKGROUND_DISABLED = Color(0xff555555);
  static const Color CONTROLS_FILL_DISABLED = Color(0xff888888);

  static const Color NODE_BORDER = Colors.white;
  static const Color NODE_FOG = Color(0x88000000);

  static const Color UNIT_HEALTH_BACKGROUND = Colors.grey;
  static const Color UNIT_HEALTH_BORDER = Colors.white;

  static const Color UNIT_INDICATOR_BACKGROUND = Colors.black;
  static const Color UNIT_INDICATOR_FOREGROUND = Colors.white;

  static Paint paint({
    PaintingStyle? style,
    Color? color,
    double? strokeWidth,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
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

    if (strokeCap != null) {
      paint.strokeCap = strokeCap;
    }

    if (strokeJoin != null) {
      paint.strokeJoin = strokeJoin;
    }

    return paint;
  }
}
