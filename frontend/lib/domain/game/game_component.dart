import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/battlefield_component.dart';
import 'package:tensionpath/domain/game/controls_component.dart';
import 'package:tensionpath/domain/game/nodes/node_checkpoint_component.dart';
import 'package:tensionpath/domain/game/nodes/node_chest_component.dart';
import 'package:tensionpath/domain/game/nodes/node_credit_generator.dart';
import 'package:tensionpath/domain/game/nodes/node_launcher_component.dart';
import 'package:tensionpath/domain/game/nodes/node_unit_generator.dart';
import 'package:tensionpath/domain/game/nodes/node_victory_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/nodes/node_checkpoint.dart';
import 'package:tensionpath/domain/state/game/nodes/node_chest.dart';
import 'package:tensionpath/domain/state/game/nodes/node_credit_generator.dart';
import 'package:tensionpath/domain/state/game/nodes/node_launcher.dart';
import 'package:tensionpath/domain/state/game/nodes/node_unit_generator.dart';
import 'package:tensionpath/domain/state/game/nodes/node_victory.dart';

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
      bottomBoundary + 150,
    ));
    camera.moveTo(Vector2(
      CONTAINER_WIDTH / 2,
      halfScreenHeight + bottomBoundary,
    ));

    camera.viewport.add(ControlsComponent(
      player: state.self,
      position: Vector2(0, effectiveScreenHeight - 150),
      size: Vector2(CONTAINER_WIDTH, 150),
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
      if (node is NodeLauncher) {
        add(NodeLauncherComponent(
          node: node,
          size: state.battlefield.nodeSize,
        ));
      } else if (node is NodeVictory) {
        add(NodeVictoryComponent(
          node: node,
          size: state.battlefield.nodeSize,
        ));
      } else if (node is NodeChest) {
        add(NodeChestComponent(
          node: node,
          size: state.battlefield.nodeSize,
        ));
      } else if (node is NodeCreditGenerator) {
        add(NodeCreditGeneratorComponent(
          node: node,
          size: state.battlefield.nodeSize,
        ));
      } else if (node is NodeUnitGenerator) {
        add(NodeUnitGeneratorComponent(
          node: node,
          size: state.battlefield.nodeSize,
        ));
      } else if (node is NodeCheckpoint) {
        add(NodeCheckpointComponent(
          node: node,
          size: state.battlefield.nodeSize,
        ));
      }
    }
  }
}
