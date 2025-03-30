import 'dart:ui';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';

class Dimensions {
  static Size cameraSize(Vector2 canvasSize) => Size(
    (canvasSize.x * Constants.UI_HEIGHT / canvasSize.y).round().toDouble(),
    Constants.UI_HEIGHT,
  );

  static Vector2 headerPosition(Size resolution) =>
      Vector2(-resolution.width / 2, -resolution.height / 2);

  static Vector2 headerSize(Size resolution) =>
      Vector2(resolution.width, resolution.height * 0.05);
}
