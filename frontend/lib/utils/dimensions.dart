import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/size.dart';

class Dimensions {
  static Vector2 cameraSize(Vector2 canvasSize) => Vector2(
    (canvasSize.x * Constants.UI_HEIGHT / canvasSize.y).round().toDouble(),
    Constants.UI_HEIGHT,
  );

  static Vector2 controlsPosition({
    required Vector2 resolution,
    required bool isPlayer1,
  }) {
    if (isPlayer1) {
      return Vector2(-resolution.x / 2, -resolution.y / 2);
    } else {
      return Vector2(
        (resolution.x / 2) - controlsSize(resolution).x,
        -resolution.y / 2,
      );
    }
  }

  static Vector2 controlsSize(Vector2 resolution) =>
      Vector2(resolution.y * 0.2, resolution.y);

  static Vector2 headerPosition({
    required Vector2 resolution,
    required bool isPlayer1,
  }) {
    if (isPlayer1) {
      return Vector2(
        (-resolution.x / 2) + controlsSize(resolution).x,
        -resolution.y / 2,
      );
    } else {
      return Vector2(-resolution.x / 2, -resolution.y / 2);
    }
  }

  static Vector2 headerSize(Vector2 resolution) => Vector2(
    resolution.x - controlsSize(resolution).x,
    resolution.y * 0.05,
  );

  static Vector2 battlefieldPosition({
    required Vector2 resolution,
    required bool isPlayer1,
  }) {
    if (isPlayer1) {
      return Vector2(
        (-resolution.x / 2) + controlsSize(resolution).x,
        (-resolution.y / 2) + headerSize(resolution).y,
      );
    } else {
      return Vector2(
        -resolution.x / 2,
        (-resolution.y / 2) + headerSize(resolution).y,
      );
    }
  }

  static Vector2 battlefieldSize(Vector2 resolution) => Vector2(
    resolution.x - controlsSize(resolution).x,
    resolution.y - headerSize(resolution).y,
  );

  static Vector2 _maxNodeSizeWidth({
    required Vector2 canvasSize,
    required Size mapSize,
  }) {
    final double maxWidth = canvasSize.x / (mapSize.width * 1.15);

    return Vector2(maxWidth, maxWidth / (sqrt(3) / 2));
  }

  static Vector2 _maxNodeSizeHeight({
    required Vector2 canvasSize,
    required Size mapSize,
  }) {
    final double maxHeight = canvasSize.y / (mapSize.height * 0.85);

    return Vector2(maxHeight * (sqrt(3) / 2), maxHeight);
  }

  static Vector2 nodeSize({
    required Vector2 canvasSize,
    required Size mapSize,
  }) {
    final Vector2 maxSizeWidth = _maxNodeSizeWidth(
      canvasSize: canvasSize,
      mapSize: mapSize,
    );
    final Vector2 maxSizeHeight = _maxNodeSizeHeight(
      canvasSize: canvasSize,
      mapSize: mapSize,
    );

    return (maxSizeWidth.x > maxSizeHeight.x) ? maxSizeHeight : maxSizeWidth;
  }

  static num nodeSizeRatio({
    required Vector2 localNodeSize,
    required Size removeNodeSize,
  }) => localNodeSize.x / removeNodeSize.width;

  static double _controlsGapSize(Vector2 size) => size.x * 0.07;

  static Vector2 controlsCardSize({
    required Vector2 size,
    required int numberOfCards,
  }) {
    final double gapSize = Dimensions._controlsGapSize(size);
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
    final double gapSize = Dimensions._controlsGapSize(size);

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
    final double gapSize = Dimensions._controlsGapSize(size);

    return Vector2(
      gapSize,
      ((numberOfCards - 1) * cardSize.y) +
          (gapSize * numberOfCards) +
          (gapSize * 1.5),
    );
  }

  static Vector2 controlsBuildingCardPosition({
    required Vector2 size,
    required Vector2 cardSize,
    required int previousCards,
  }) {
    final double gapSize = Dimensions._controlsGapSize(size);

    return Vector2(
      gapSize,
      (previousCards * cardSize.y) + ((previousCards + 1) * gapSize),
    );
  }

  static Vector2 controlsBuildingCardSize({
    required Vector2 size,
    required Vector2 cardSize,
    required int cards,
  }) {
    final double gapSize = Dimensions._controlsGapSize(size);

    return Vector2(
      cardSize.x,
      (cards * cardSize.y) + ((cards - 1) * gapSize),
    );
  }

  static bool pointInCircle({
    required Vector2 point,
    required Vector2 size,
  }) {
    final Vector2 fromCenter = point - (size / 2);

    return fromCenter.length < (size.x * 0.6);
  }

  static Vector2 fpsPosition({
    required Player self,
    required Viewport viewport,
  }) {
    if (self.isPlayer1) {
      return Vector2(
        viewport.size.x - (viewport.size.x * 0.06),
        viewport.size.y - (viewport.size.y * 0.05),
      );
    } else {
      return Vector2(
        viewport.size.x * 0.01,
        viewport.size.y - (viewport.size.y * 0.05),
      );
    }
  }
}
