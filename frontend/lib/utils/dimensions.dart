import 'dart:math';
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

  static Vector2 battlefieldPosition(Size resolution) => Vector2(
    (-resolution.width / 2) + controlsSize(resolution).x,
    (-resolution.height / 2) + headerSize(resolution).y,
  );

  static Vector2 battlefieldSize(Size resolution) => Vector2(
    resolution.width - controlsSize(resolution).x,
    resolution.height - headerSize(resolution).y,
  );

  static double nodeSize({
    required Vector2 canvasSize,
    required Size battlefieldSize,
  }) => (canvasSize.y / battlefieldSize.height) * 1.15;

  static Vector2 nodePosition({
    required double nodeSize,
    required int x,
    required int y,
  }) {
    final double hexWidth = nodeSize;
    final double hexHeight = nodeSize * (sqrt(3) / 2);

    return Vector2(hexWidth * 3 / 4 * x, hexHeight * ((x / 2) + y));
  }
}
