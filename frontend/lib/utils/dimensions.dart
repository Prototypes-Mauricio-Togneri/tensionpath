import 'dart:ui';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';

class Dimensions {
  static Size cameraSize(Vector2 canvasSize) => Size(
    (canvasSize.x * Constants.UI_HEIGHT / canvasSize.y).round().toDouble(),
    Constants.UI_HEIGHT,
  );

  static Vector2 headerPosition(Size resolution) => Vector2(
    (-resolution.width / 2) + controlsSize(resolution).x,
    -resolution.height / 2,
  );

  static Vector2 headerSize(Size resolution) => Vector2(
    resolution.width - controlsSize(resolution).x,
    resolution.height * 0.05,
  );

  static Vector2 controlsPosition(Size resolution) =>
      Vector2(-resolution.width / 2, -resolution.height / 2);

  static Vector2 controlsSize(Size resolution) =>
      Vector2(resolution.width * 0.1, resolution.height);
}
