import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/battlefield_component.dart';
import 'package:tensionpath/domain/game/node_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';

class GameComponent extends FlameGame with PanDetector, HasCollisionDetection {
  final GameState state;
  final double aspectRatio;
  final double pixelRatio;

  static const double CONTAINER_WIDTH = 1000;

  GameComponent({
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
      speed: pixelRatio * Constants.PAN_SPEED,
    );
  }

  @override
  FutureOr onLoad() {
    debugMode = false;
    state.setWorld(world);

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

  @override
  void update(double dt) {
    state.update(dt);

    super.update(dt);
  }
}

class GameWorld extends World {
  final GameState state;

  GameWorld(this.state);

  @override
  Future onLoad() async {
    add(BattlefieldComponent(
      state: state,
      battlefield: state.battlefield,
    ));

    for (final Node node in state.battlefield.nodes) {
      add(NodeComponent(
        state: state,
        node: node,
        size: state.battlefield.nodeSize,
      ));
    }
  }
}
