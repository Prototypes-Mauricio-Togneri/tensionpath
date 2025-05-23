import 'dart:math';
import 'dart:ui';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/location.dart';

class Dimensions {
  static Size cameraSize(Vector2 canvasSize) => Size(
    (canvasSize.x * Constants.UI_HEIGHT / canvasSize.y).round().toDouble(),
    Constants.UI_HEIGHT,
  );

  static Vector2 controlsPosition(Size resolution) => Vector2(
    -resolution.width / 2,
    (resolution.height / 2) - Constants.UI_CONTROLS_HEIGHT,
  );

  static Vector2 controlsSize(Size resolution) =>
      Vector2(resolution.width, Constants.UI_CONTROLS_HEIGHT);

  static Vector2 headerPosition(Size resolution) =>
      Vector2(-resolution.width / 2, -resolution.height / 2);

  static Vector2 headerSize(Size resolution) =>
      Vector2(resolution.width, Constants.UI_HEADER_HEIGHT);

  static Vector2 battlefieldPosition(Size resolution) => Vector2(
    -resolution.width / 2,
    (-resolution.height / 2) + headerSize(resolution).y,
  );

  static Vector2 battlefieldSize(Size resolution) => Vector2(
    resolution.width,
    resolution.height - headerSize(resolution).y - controlsSize(resolution).y,
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

  static Vector2 nodePosition({
    required Vector2 nodeSize,
    required Location location,
  }) => Vector2(
    nodeSize.x * 0.75 * location.x,
    nodeSize.y * ((location.x / 2.4) + location.y * 0.85),
  );

  static Vector2 nodeSize({
    required Vector2 size,
    required Battlefield battlefield,
  }) => Vector2(
    size.x / battlefield.size.width,
    size.y / battlefield.size.height,
  );

  static Vector2 battlefildGridPosition(Vector2 size) => size / 2;

  static Vector2 battlefildGridSize({
    required Vector2 size,
    required Battlefield battlefield,
  }) {
    final double battlefieldRatio =
        battlefield.size.height / battlefield.size.width;
    final double screenRatio = size.y / size.x;

    if (screenRatio >= battlefieldRatio) {
      return Vector2(size.x, size.x * battlefieldRatio);
    } else {
      return Vector2(size.y / battlefieldRatio, size.y);
    }
  }

  static Vector2 controlsResourcesPosition(Vector2 size) =>
      Vector2(0, size.y / 2);

  static Vector2 controlsResourcesSize(Vector2 size) =>
      Vector2(size.x * 0.3, size.y);

  static Vector2 controlsEndTurnPosition(Vector2 size) =>
      Vector2(size.x / 2, size.y / 2);

  static Vector2 controlsEndTurnSize(Vector2 size) =>
      Vector2(size.x / 4, size.y * 0.8);

  static bool pointInHexagon({required Vector2 point, required Vector2 size}) {
    final Vector2 fromCenter = point - (size / 2);

    return fromCenter.length < size.x * 0.42;
  }

  static Vector2 fpsPosition(Viewport viewport) => Vector2(
    viewport.size.x - (viewport.size.x * 0.078),
    viewport.size.y - (viewport.size.y * 0.042),
  );
}
