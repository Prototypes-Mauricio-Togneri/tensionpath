import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/models/json_battlefield.dart';
import 'package:tensionpath/domain/json/models/json_location.dart';

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

  static Vector2 maxNodeSizeWidth({
    required Vector2 canvasSize,
    required JsonBattlefield battlefield,
  }) {
    final double maxWidth = canvasSize.x / (battlefield.size.width * 1.15);

    return Vector2(maxWidth, maxWidth / (sqrt(3) / 2));
  }

  static Vector2 maxNodeSizeHeight({
    required Vector2 canvasSize,
    required JsonBattlefield battlefield,
  }) {
    final double maxHeight = canvasSize.y / (battlefield.size.height * 0.85);

    return Vector2(maxHeight * (sqrt(3) / 2), maxHeight);
  }

  static Vector2 nodeSize({
    required Vector2 canvasSize,
    required JsonBattlefield battlefield,
  }) {
    final Vector2 maxSizeWidth = maxNodeSizeWidth(
      canvasSize: canvasSize,
      battlefield: battlefield,
    );
    final Vector2 maxSizeHeight = maxNodeSizeHeight(
      canvasSize: canvasSize,
      battlefield: battlefield,
    );

    return (maxSizeWidth.x > maxSizeHeight.x) ? maxSizeHeight : maxSizeWidth;
  }

  static Vector2 nodePosition({
    required Vector2 center,
    required Vector2 nodeSize,
    required JsonLocation location,
  }) => Vector2(
    center.x + (nodeSize.x * ((location.y / 2) + location.x)),
    center.y + (nodeSize.y * 3 / 4 * location.y),
  );

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

  static bool pointInHexagon({required Vector2 point, required Vector2 size}) {
    final Vector2 fromCenter = point - (size / 2);

    return fromCenter.length < size.x * 0.42;
  }

  static Vector2 fpsPosition(Viewport viewport) => Vector2(
    viewport.size.x - (viewport.size.x * 0.06),
    viewport.size.y - (viewport.size.y * 0.05),
  );
}
