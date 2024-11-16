import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/base_indicator_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';

class GameComponent extends FlameGame with HasCollisionDetection {
  final GameState state;

  GameComponent(this.state) : super(world: MatchComponent(state));

  @override
  FutureOr onLoad() {
    camera = CameraComponent.withFixedResolution(
      height: Constants.SCREEN_HEIGHT,
      width: Constants.SCREEN_WIDTH,
    );

    camera.moveTo(Vector2(
      Constants.SCREEN_WIDTH / 2,
      (Constants.SCREEN_HEIGHT / 2) - Constants.UI_BASE_HEIGHT,
    ));

    debugMode = false;
    state.setGameComponent(this);

    camera.viewport.add(ControlsComponent(
      player: state.self,
      position: Vector2(
        Constants.SCREEN_WIDTH / 2,
        size.y - (Constants.UI_CONTROLS_HEIGHT / 2),
      ),
      size: Vector2(
        Constants.SCREEN_WIDTH,
        Constants.UI_CONTROLS_HEIGHT,
      ),
    ));

    final Battlefield battlefield = state.battlefield;

    camera.viewport.add(BaseIndicatorComponent(
      base: battlefield.baseSelf,
      position: Vector2(
        Constants.SCREEN_WIDTH / 2,
        size.y -
            Constants.UI_CONTROLS_HEIGHT -
            (Constants.UI_BASE_HEIGHT / 2) +
            1,
      ),
      size: Vector2(
        Constants.SCREEN_WIDTH,
        Constants.UI_BASE_HEIGHT,
      ),
    ));

    camera.viewport.add(BaseIndicatorComponent(
      base: battlefield.baseEnemy,
      position: Vector2(
        Constants.SCREEN_WIDTH / 2,
        Constants.UI_BASE_HEIGHT / 2,
      ),
      size: Vector2(
        Constants.SCREEN_WIDTH,
        Constants.UI_BASE_HEIGHT,
      ),
    ));

    if (debugMode) {
      add(FpsTextComponent());
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Colors.yellow;

  @override
  void update(double dt) {
    state.update(dt);

    super.update(dt);
  }
}
