import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primary = Colors.blue;
  static const Color transparent = Colors.transparent;

  static const Color GAME_BACKGROUND = Colors.black;

  static const Color PLAYER_1 = Color(0xff2479ae);
  static const Color PLAYER_2 = Color(0xffd54336);

  static const Color HEADER_PLAYER_NAME = Colors.white;
  static const Color HEADER_CENTER_BACKGROUND = Colors.grey;
  static const Color HEADER_INDICATOR_BACKGROUND = Color(0xff555555);

  static const Color CONTROLS_COST_FOREGROUND = Colors.white;
  static const Color CONTROLS_COST_BACKGROUND = Color(0x77000000);
  static const Color CONTROLS_RESOURCES_BACKGROUND = Colors.grey;
  static const Color CONTROLS_RESOURCES_FOREGROUND = Colors.white;
  static const Color CONTROLS_END_TURN_BACKGROUND_ENABLED = Colors.green;
  static const Color CONTROLS_END_TURN_BACKGROUND_DISABLED = Colors.grey;
  static const Color CONTROLS_POPCAP_BACKGROUND = Colors.white;

  static const Color NODE_BORDER = Colors.white;
  static const Color NODE_FOG = Color(0x88000000);

  static const Color UNIT_HEALTH_BACKGROUND = Colors.grey;
  static const Color UNIT_HEALTH_BORDER = Colors.white;
  static const Color UNIT_INDICATOR_BACKGROUND = Colors.black;
  static const Color UNIT_INDICATOR_FOREGROUND = Colors.white;

  static const Color MISSILE_OWNER_NONE = Colors.grey;
  static const Color MISSILE_OWNER_CONTESTED = Color(0xffefaf09);
  static const Color MISSILE_INDICATOR_BACKGROUND = Colors.white;
  static const Color MISSILE_INDICATOR_PLACEHOLDER = Color(0xffdddddd);

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
