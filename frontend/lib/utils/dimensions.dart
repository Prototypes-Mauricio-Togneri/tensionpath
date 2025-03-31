import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';

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

  static Size maxNodeSizeWidth({
    required Vector2 canvasSize,
    required Battlefield battlefield,
  }) {
    final double maxWidth = canvasSize.x / battlefield.size.width;

    return Size(maxWidth, maxWidth / (sqrt(3) / 2));
  }

  static Size maxNodeSizeHeight({
    required Vector2 canvasSize,
    required Battlefield battlefield,
  }) {
    final double maxHeight =
        canvasSize.y / ((battlefield.size.height * 3 / 4) + 0.25);

    return Size(maxHeight * (sqrt(3) / 2), maxHeight);
  }

  static Size nodeSize({
    required Vector2 canvasSize,
    required Battlefield battlefield,
  }) {
    final Size maxSizeWidth = maxNodeSizeWidth(
      canvasSize: canvasSize,
      battlefield: battlefield,
    );
    final Size maxHeightWidth = maxNodeSizeHeight(
      canvasSize: canvasSize,
      battlefield: battlefield,
    );

    return (maxSizeWidth.width > maxHeightWidth.width)
        ? maxHeightWidth
        : maxSizeWidth;
  }

  static Vector2 nodePosition({
    required Size nodeSize,
    required int x,
    required int y,
  }) => Vector2(nodeSize.width * ((x / 2) + y), nodeSize.height * 3 / 4 * x);

  static Vector2 battlefildGridSize(Vector2 containerSize) {
    final double padding = containerSize.y * 0.1;

    return Vector2(containerSize.x - padding, containerSize.y - padding);
  }

  static Vector2 battlefieldBackgroundSize({
    required Vector2 canvasSize,
    required Vector2 imageSize,
    required Vector2 gridSize,
    required Battlefield battlefield,
  }) {
    final double ratio = imageSize.x / imageSize.y;

    final Size maxSizeWidth = maxNodeSizeWidth(
      canvasSize: canvasSize,
      battlefield: battlefield,
    );
    final Size maxHeightWidth = maxNodeSizeHeight(
      canvasSize: canvasSize,
      battlefield: battlefield,
    );

    if (maxSizeWidth.width > maxHeightWidth.width) {
      final double backgroundHeightAdjusted =
          gridSize.y / battlefield.gridRatio.height;
      final double backgroundWidthAdjusted = backgroundHeightAdjusted * ratio;

      return Vector2(backgroundWidthAdjusted, backgroundHeightAdjusted);
    } else {
      final double backgroundWidthAdjusted =
          gridSize.x / battlefield.gridRatio.width;
      final double backgroundHeightAdjusted = backgroundWidthAdjusted / ratio;

      return Vector2(backgroundWidthAdjusted, backgroundHeightAdjusted);
    }
  }
}
