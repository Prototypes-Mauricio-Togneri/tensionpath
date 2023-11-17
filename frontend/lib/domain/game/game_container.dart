import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/utils/sprites.dart';

class GameContainer extends FlameGame with PanDetector {
  static const double CONTAINER_WIDTH = 1000;
  final MediaQueryData mediaQueryData;

  GameContainer(this.mediaQueryData)
      : super(
          camera: CameraComponent.withFixedResolution(
            width: CONTAINER_WIDTH,
            height: CONTAINER_WIDTH / mediaQueryData.size.aspectRatio,
          ),
          world: GameWorld(),
        );

  double get effectiveScreenHeight =>
      (camera.viewport.size.y * CONTAINER_WIDTH) / camera.viewport.size.x;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    camera.moveBy(
      Vector2(0, -info.delta.global.y * mediaQueryData.devicePixelRatio),
      speed: mediaQueryData.devicePixelRatio * 1000,
    );
  }

  @override
  FutureOr onLoad() {
    final double halfScreenHeight = effectiveScreenHeight / 2;
    final double bottomBoundary =
        Sprites.MAP.image.size.y - effectiveScreenHeight;

    camera.setBounds(Rectangle.fromLTWH(
      0,
      halfScreenHeight,
      CONTAINER_WIDTH,
      bottomBoundary,
    ));
    camera.moveTo(Vector2(
      CONTAINER_WIDTH / 2,
      halfScreenHeight + bottomBoundary,
    ));

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Colors.black;
}

class GameWorld extends World with HasGameRef {
  @override
  Future onLoad() async {
    add(Background());
    add(Player());
  }
}

class Background extends SpriteComponent {
  Background()
      : super(
          sprite: Sprites.MAP,
          position: Vector2(0, 0),
          size: Sprites.MAP.image.size,
          anchor: Anchor.topLeft,
          priority: -1,
        );
}

class Player extends SpriteComponent {
  Player()
      : super(
          sprite: Sprites.PLAYER,
          position: Vector2(100, 100),
          size: Vector2(150, 210),
          anchor: Anchor.center,
        );
}
