import 'dart:ui';
import 'package:flame/components.dart';

extension ComponentExtension on SpriteComponent {
  void setBlueShade() {
    const ColorFilter channelFilter = ColorFilter.matrix([
      0, 0, 0, 0, 0, // Red channel: zero out
      0, 0, 0, 0, 0, // Green channel: zero out
      0, 0, 1, 0, 0, // Blue channel: keep blue
      0, 0, 0, 1, 0, // Alpha channel: keep alpha
    ]);

    paint.colorFilter = channelFilter;
  }

  void setRedShade() {
    const ColorFilter channelFilter = ColorFilter.matrix([
      1, 0, 0, 0, 0, // Red channel: keep red
      0, 0, 0, 0, 0, // Green channel: zero out
      0, 0, 0, 0, 0, // Blue channel: zero out
      0, 0, 0, 1, 0, // Alpha channel: keep alpha
    ]);

    paint.colorFilter = channelFilter;
  }
}
