import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/utils/sprites.dart';

class GameContainer extends FlameGame with PanDetector {
  final GameState gameState;
  final double aspectRatio;
  final double pixelRatio;

  static const double CONTAINER_WIDTH = 1000;

  GameContainer({
    required this.gameState,
    required this.aspectRatio,
    required this.pixelRatio,
  }) : super(
          camera: CameraComponent.withFixedResolution(
            width: CONTAINER_WIDTH,
            height: CONTAINER_WIDTH / aspectRatio,
          ),
          world: GameWorld(gameState),
        );

  double get effectiveScreenHeight =>
      (camera.viewport.size.y * CONTAINER_WIDTH) / camera.viewport.size.x;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    camera.moveBy(
      Vector2(0, -info.delta.global.y * pixelRatio),
      speed: pixelRatio * 1000,
    );
  }

  @override
  FutureOr onLoad() {
    final double halfScreenHeight = effectiveScreenHeight / 2;
    final double bottomBoundary =
        gameState.mapSprite.image.size.y - effectiveScreenHeight;

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
  final GameState gameState;

  GameWorld(this.gameState);

  @override
  Future onLoad() async {
    add(Background(
      sprite: gameState.mapSprite,
    ));
    add(Player());
  }
}

class Background extends SpriteComponent {
  Background({required super.sprite})
      : super(
          position: Vector2(0, 0),
          size: sprite!.image.size,
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
