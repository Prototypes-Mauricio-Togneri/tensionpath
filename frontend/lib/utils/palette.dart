import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primary = Colors.blue;
  static const Color transparent = Colors.transparent;

  static const Color GAME_BACKGROUND = Colors.black;

  static const Color SNACK_BACKGROUND = Colors.red;

  static const Color DEBUG_TEXT = Colors.white;

  static const Color PLAYER_1 = Color(0xff2479ae);
  static const Color PLAYER_2 = Color(0xffd54336);

  static const Color HEADER_PLAYER_NAME = Colors.white;
  static const Color HEADER_CENTER_BACKGROUND = Colors.grey;
  static const Color HEADER_INDICATOR_BACKGROUND = Color(0xff555555);

  static const Color CONTROLS_COST_FOREGROUND = Colors.white;
  static const Color CONTROLS_END_TURN_BACKGROUND_ENABLED = Colors.green;
  static const Color CONTROLS_END_TURN_BACKGROUND_DISABLED = Colors.grey;

  static const Color NODE_FOG = Color(0x88000000);

  static const Color BATTLEFIELD_BACKGROUND = Color(0xff222222);

  static const Color NODE_EMPTY_BACKGROUND = Color(0xff333333);
  static const Color NODE_LAUNCHER_1_BORDER = Color(0xff135179);
  static const Color NODE_LAUNCHER_1_BACKGROUND = Color(0xff2882B4);
  static const Color NODE_LAUNCHER_2_BORDER = Color(0xffA9271E);
  static const Color NODE_LAUNCHER_2_BACKGROUND = Color(0xffD14034);
  static const Color NODE_MISSILE_BORDER = Color(0xffEBA80E);
  static const Color NODE_MISSILE_BACKGROUND = Color(0xffF3C11E);
  static const Color NODE_RESOURCES_BORDER = Color(0xff131313);
  static const Color NODE_RESOURCES_BACKGROUND = Color(0xff353535);

  static const Color UNIT_AMOUNT_INDICATOR = Colors.white;
  static const Color UNIT_MOVEMENT_INDICATOR_VALID = Colors.white;
  static const Color UNIT_MOVEMENT_INDICATOR_INVALID = Color(0xff444444);

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
