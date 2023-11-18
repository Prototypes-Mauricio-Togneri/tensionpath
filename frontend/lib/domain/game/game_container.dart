import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/utils/sprites.dart';

class GameContainer extends FlameGame with PanDetector {
  final GameState state;
  final double aspectRatio;
  final double pixelRatio;

  static const double CONTAINER_WIDTH = 1000;

  GameContainer({
    required this.state,
    required this.aspectRatio,
    required this.pixelRatio,
  }) : super(
          camera: CameraComponent.withFixedResolution(
            width: CONTAINER_WIDTH,
            height: CONTAINER_WIDTH / aspectRatio,
          ),
          world: GameWorld(state),
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
        state.battlefield.sprite.image.size.y - effectiveScreenHeight;

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

class GameWorld extends World {
  final GameState gameState;

  GameWorld(this.gameState);

  @override
  Future onLoad() async {
    add(Background(
      sprite: gameState.battlefield.sprite,
    ));
    add(Player());

    for (final Node node in gameState.battlefield.nodes) {
      add(NodeComponent(
        id: node.id,
        position: node.position,
      ));
    }
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

class NodeComponent extends SpriteComponent {
  final String id;

  NodeComponent({
    required super.position,
    required this.id,
  }) : super(
          sprite: Sprites.NODE,
          size: Vector2(200, 200),
          anchor: Anchor.center,
        );
}
