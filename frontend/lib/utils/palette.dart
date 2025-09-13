import 'dart:ui';
import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor PRIMARY = Colors.blue;
  static const Color TRANSPARENT = Colors.transparent;

  static const Color SCREEN_BACKGROUND = Colors.white;
  static const Color GAME_BACKGROUND = Colors.black;

  static const Color PLAYER_1 = Color(0xff2479ae);
  static const Color PLAYER_2 = Color(0xffd54336);

  static const Color HEADER_PLAYER_NAME = Colors.white;
  static const Color HEADER_CENTER_BACKGROUND = Colors.grey;
  static const Color HEADER_INDICATOR_BACKGROUND = Color(0xff555555);

  static const Color CONTROLS_COST_FOREGROUND = Colors.white;

  static const Color NODE_BORDER = Color(0x30aaaaaa);
  static const Color NODE_HIGHLIGHT = Colors.white;
  static const Color NODE_TARGET = Colors.white;
  static const Color NODE_FOG = Color(0x88000000);

  static const Color RESOURCES = Color(0xff149434);

  static const Color PAD_NEUTRAL = Color(0xff149434);
  static const Color PAD_CONTESTED = Color(0xff149434);

  static const Color UNIT_HEALTH_BORDER = Colors.white;

  static const Color MISSILE_OWNER_NONE = Colors.grey;
  static const Color MISSILE_OWNER_CONTESTED = Color(0xffefaf09);
  static const Color MISSILE_INDICATOR_BACKGROUND = Colors.white;
  static const Color MISSILE_INDICATOR_BORDERR = Color(0xffdddddd);

  // ======================================================================== \\

  static const Color SEMANTIC_SUCCESS = Colors.green;
  static const Color SEMANTIC_ERROR = Colors.red;

  static const Color TEXT_COLOR_PRIMARY = Color(0xff444444);
  static const Color TEXT_COLOR_SECONDARY = Color(0xffaaaaaa);
  static const Color TEXT_COLOR_TERTIARY = Color(0xffffffff);
  static const Color TEXT_DEBUG = Colors.white;

  static const Color BUTTON_DISABLED = Colors.black26;

  static const Color ICON_ENABLED = Colors.black38;

  static const Color SNACK_BACKGROUND = Colors.red;

  static Paint paint({
    PaintingStyle? style,
    Color? color,
    double? strokeWidth,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    BlendMode? blendMode,
    double? blurSigma,
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

    if (blendMode != null) {
      paint.blendMode = blendMode;
    }

    if (blurSigma != null && blurSigma > 0) {
      paint.imageFilter = ImageFilter.blur(
        sigmaX: blurSigma,
        sigmaY: blurSigma,
      );
    }

    return paint;
  }
}
