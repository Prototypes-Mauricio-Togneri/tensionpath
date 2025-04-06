import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primary = Colors.blue;
  static const Color transparent = Colors.transparent;

  static const Color GAME_BACKGROUND = Colors.black;

  static const Color PLAYER_SELF = Colors.blue;
  static const Color PLAYER_OPPONENT = Colors.red;
  static const Color PLAYER_NAME = Colors.white;

  static const Color HEADER_BACKGROUND = Colors.green;

  static Color BATTLEFIELD_BACKGROUND = const Color(0xff333333);

  static const Color CONTROLS_BACKGROUND = Colors.green;
  static const Color CONTROLS_RESOURCES_BACKGROUND = Colors.orange;
  static const Color CONTROLS_RESOURCES_FOREGROUND = Colors.white;
  static const Color CONTROLS_UNIT_BORDER_DISABLED = Color(0xff555555);
  static const Color CONTROLS_UNIT_FILL_DISABLED = Color(0xff888888);

  static Color NODE_BORDER = Colors.white;
  static const Color NODE_RESOURCES = Colors.black45;
  static const Color NODE_MISSILE = Colors.brown;
  static const Color NODE_PLATFORM = Color(0xff666666);

  static const Color UNIT_HEALTH_BACKGROUND = Colors.grey;
  static const Color UNIT_HEALTH_BORDERD = Colors.white;

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
