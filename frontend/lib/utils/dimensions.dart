import 'dart:math';
import 'dart:ui';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';

class Dimensions {
  static Size cameraSize(Vector2 canvasSize) => Size(
    (canvasSize.x * Constants.UI_HEIGHT / canvasSize.y).round().toDouble(),
    Constants.UI_HEIGHT,
  );

  static Vector2 controlsPosition({
    required Size resolution,
    required bool isPlayer1,
  }) {
    if (isPlayer1) {
      return Vector2(-resolution.width / 2, -resolution.height / 2);
    } else {
      return Vector2(
        (resolution.width / 2) - controlsSize(resolution).x,
        -resolution.height / 2,
      );
    }
  }

  static Vector2 controlsSize(Size resolution) =>
      Vector2(resolution.height * 0.2, resolution.height);

  static Vector2 headerPosition({
    required Size resolution,
    required bool isPlayer1,
  }) {
    if (isPlayer1) {
      return Vector2(
        (-resolution.width / 2) + controlsSize(resolution).x,
        -resolution.height / 2,
      );
    } else {
      return Vector2(-resolution.width / 2, -resolution.height / 2);
    }
  }

  static Vector2 headerSize(Size resolution) => Vector2(
    resolution.width - controlsSize(resolution).x,
    resolution.height * 0.05,
  );

  static Vector2 battlefieldPosition({
    required Size resolution,
    required bool isPlayer1,
  }) {
    if (isPlayer1) {
      return Vector2(
        (-resolution.width / 2) + controlsSize(resolution).x,
        (-resolution.height / 2) + headerSize(resolution).y,
      );
    } else {
      return Vector2(
        -resolution.width / 2,
        (-resolution.height / 2) + headerSize(resolution).y,
      );
    }
  }

  static Vector2 battlefieldSize(Size resolution) => Vector2(
    resolution.width - controlsSize(resolution).x,
    resolution.height - headerSize(resolution).y,
  );

  static Size maxNodeSizeWidth({
    required Vector2 canvasSize,
    required JsonBattlefield battlefield,
  }) {
    final double maxWidth = canvasSize.x / battlefield.size.width;

    return Size(maxWidth, maxWidth / (sqrt(3) / 2));
  }

  static Size maxNodeSizeHeight({
    required Vector2 canvasSize,
    required JsonBattlefield battlefield,
  }) {
    final double maxHeight =
        canvasSize.y / ((battlefield.size.height * 3 / 4) + 0.25);

    return Size(maxHeight * (sqrt(3) / 2), maxHeight);
  }

  static Size nodeSize({
    required Vector2 canvasSize,
    required JsonBattlefield battlefield,
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
    required Location location,
  }) => Vector2(
    nodeSize.width * ((location.y / 2) + location.x),
    nodeSize.height * 3 / 4 * location.y,
  );

  static Vector2 battlefildGridSize(Vector2 containerSize) {
    final double padding = containerSize.y * 0.05;

    return Vector2(containerSize.x - padding, containerSize.y - padding);
  }

  static Vector2 battlefieldBackgroundSize({
    required Vector2 canvasSize,
    required Vector2 imageSize,
    required Vector2 gridSize,
    required JsonBattlefield battlefield,
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

  static double controlsGapSize(Vector2 size) => size.x * 0.07;

  static Vector2 controlsCardSize({
    required Vector2 size,
    required int numberOfCards,
  }) {
    final double gapSize = Dimensions.controlsGapSize(size);
    final double cardWidth = size.x - (gapSize * 2);
    final double cardHeight =
        (size.y - gapSize - (gapSize * (numberOfCards + 1))) / numberOfCards;

    return Vector2(cardWidth, cardHeight);
  }

  static Vector2 controlsUnitCardPosition({
    required Vector2 size,
    required Vector2 cardSize,
    required int i,
  }) {
    final double gapSize = Dimensions.controlsGapSize(size);

    return Vector2(
      gapSize + (cardSize.x / 2),
      ((i + 0.5) * cardSize.y) + ((i + 1) * gapSize),
    );
  }

  static Vector2 controlsResourcesCardPosition({
    required Vector2 size,
    required Vector2 cardSize,
    required int numberOfCards,
  }) {
    final double gapSize = Dimensions.controlsGapSize(size);

    return Vector2(
      gapSize,
      ((numberOfCards - 2) * cardSize.y) +
          (gapSize * (numberOfCards - 1)) +
          gapSize,
    );
  }

  static Vector2 controlsEndTurnCardPosition({
    required Vector2 size,
    required Vector2 cardSize,
    required int numberOfCards,
  }) {
    final double gapSize = Dimensions.controlsGapSize(size);

    return Vector2(
      gapSize,
      ((numberOfCards - 1) * cardSize.y) + (gapSize * numberOfCards) + gapSize,
    );
  }

  static bool pointInHexagon({required Vector2 point, required Vector2 size}) {
    final Vector2 fromCenter = point - (size / 2);

    return fromCenter.length < size.x * 0.42;
  }

  static Vector2 fpsPosition(Viewport viewport) => Vector2(
    viewport.size.x - (viewport.size.x * 0.06),
    viewport.size.y - (viewport.size.y * 0.05),
  );
}
