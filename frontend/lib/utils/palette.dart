import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor PRIMARY = Colors.blue;
  static const Color TRANSPARENT = Colors.transparent;

  static const Color SCREEN_BACKGROUND = Colors.white;
  static const Color GAME_BACKGROUND = Colors.black;

  static const Color SEMANTIC_SUCCESS = Colors.green;
  static const Color SEMANTIC_ERROR = Colors.red;

  static const Color TEXT_COLOR_PRIMARY = Color(0xff444444);
  static const Color TEXT_COLOR_SECONDARY = Color(0xffaaaaaa);
  static const Color TEXT_COLOR_TERTIARY = Color(0xffffffff);
  static const Color TEXT_DEBUG = Colors.white;

  static const Color BUTTON_DISABLED = Colors.black26;

  static const Color ICON_ENABLED = Colors.black38;

  static const Color SNACK_BACKGROUND = Colors.red;

  static const Color PLAYER_1 = Color(0xff2479ae);
  static const Color PLAYER_2 = Color(0xffd54336);

  static const Color HEADER_PLAYER_NAME = Colors.white;
  static const Color HEADER_CENTER_BACKGROUND = Colors.grey;
  static const Color HEADER_INDICATOR_BACKGROUND = Color(0xff555555);

  static const Color CONTROLS_COST_FOREGROUND = Colors.white;
  static const Color CONTROLS_END_TURN_BACKGROUND_ENABLED = Colors.green;
  static const Color CONTROLS_END_TURN_BACKGROUND_DISABLED = Colors.grey;
  static const Color CONTROLS_UNIT_TYPE_SELECTED = Colors.white;

  static const Color NODE_FOG = Color(0xaa000000);

  static const Color BATTLEFIELD_BACKGROUND = Color(0xff222222);

  static const Color NODE_HIGHLIGHT_BORDER = Color(0xffffffff);
  static const Color NODE_EMPTY_BACKGROUND = Color(0xFFFFC13C);
  static const Color NODE_LAUNCHER_1_BORDER = Color(0xff135179);
  static const Color NODE_LAUNCHER_1_BACKGROUND = Color(0xff2882B4);
  static const Color NODE_LAUNCHER_2_BORDER = Color(0xffA9271E);
  static const Color NODE_LAUNCHER_2_BACKGROUND = Color(0xffD14034);
  static const Color NODE_MISSILE_BORDER = Color.fromARGB(255, 94, 16, 167);
  static const Color NODE_MISSILE_BACKGROUND = Color(0xFF7E35C4);
  static const Color NODE_RESOURCES_BORDER = Color(0xFF14742F);
  static const Color NODE_RESOURCES_BACKGROUND = Color(0xFF1E9941);

  static const Color NODE_PAD_NEUTRAL_BORDER = Color(0xff686A68);
  static const Color NODE_PAD_CONTESTED_BORDER = Color(0xffECAA0D);
  static const Color NODE_PAD_BACKGROUND = Color(0xff8A898B);

  static const Color UNIT_LEVEL_INDICATOR = Colors.white;
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
