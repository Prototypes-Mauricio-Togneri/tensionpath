import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';

class Dimensions {
  static Size cameraSize(Vector2 canvasSize) => Size(
    (canvasSize.x * Constants.UI_HEIGHT / canvasSize.y).round().toDouble(),
    Constants.UI_HEIGHT,
  );

  static Vector2 controlsPosition(Size resolution) =>
      Vector2(-resolution.width / 2, -resolution.height / 2);

  static Vector2 controlsSize(Size resolution) =>
      Vector2(resolution.width * 0.1, resolution.height);

  static Vector2 headerPosition(Size resolution) => Vector2(
    (-resolution.width / 2) + controlsSize(resolution).x,
    -resolution.height / 2,
  );

  static Vector2 headerSize(Size resolution) => Vector2(
    resolution.width - controlsSize(resolution).x,
    resolution.height * 0.05,
  );

  static Vector2 battlefieldPosition(Size resolution) => Vector2(
    (-resolution.width / 2) + controlsSize(resolution).x,
    (-resolution.height / 2) + headerSize(resolution).y,
  );

  static Vector2 battlefieldSize(Size resolution) => Vector2(
    resolution.width - controlsSize(resolution).x,
    resolution.height - headerSize(resolution).y,
  );

  static Size nodeSize({
    required Vector2 canvasSize,
    required Size battlefieldSize,
  }) {
    final double maxWidth = canvasSize.x / battlefieldSize.width;
    final Size maxSizeWidth = Size(maxWidth, maxWidth / (sqrt(3) / 2));

    final double maxHeight =
        canvasSize.y / ((battlefieldSize.height * 3 / 4) + 0.25);
    final Size maxHeightWidth = Size(maxHeight * (sqrt(3) / 2), maxHeight);

    return Size(
      min(maxSizeWidth.width, maxHeightWidth.width),
      min(maxSizeWidth.height, maxHeightWidth.height),
    );
  }

  static Vector2 nodePosition({
    required Size nodeSize,
    required int x,
    required int y,
  }) => Vector2(nodeSize.width * ((x / 2) + y), nodeSize.height * 3 / 4 * x);
}
