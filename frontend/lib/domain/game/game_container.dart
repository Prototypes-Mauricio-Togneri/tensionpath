import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/utils/palette.dart';
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
  final GameState state;

  GameWorld(this.state);

  @override
  Future onLoad() async {
    add(Background(
      sprite: state.battlefield.sprite,
    ));
    add(Player());

    for (final Node node in state.battlefield.nodes) {
      add(NodeComponent(
        state: state,
        node: node,
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

class NodeComponent extends SpriteComponent with TapCallbacks, GestureHitboxes {
  final GameState state;
  final Node node;

  NodeComponent({
    required this.state,
    required this.node,
  }) : super(
          sprite: Sprites.NODE,
          size: Vector2(200, 200),
          position: node.position,
          anchor: Anchor.center,
        );

  @override
  Future onLoad() async {
    add(
      TextComponent(
        text: node.id,
        anchor: Anchor.center,
        position: size / 2,
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: size.x / 3,
            color: Palette.grey,
          ),
        ),
      ),
    );
    add(CircleHitbox(
      radius: size.x / 2,
      position: size / 2,
      anchor: Anchor.center,
    ));

    super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) => state.onNodeSelected(node);
}
