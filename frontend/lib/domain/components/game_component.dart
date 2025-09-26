import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/utils/dimensions.dart';

class GameComponent extends FlameGame {
  final Match match;
  final MatchState matchState;

  GameComponent({
    required this.match,
    required this.matchState,
  }) {
    GameComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    final Vector2 resolution = Dimensions.cameraSize(canvasSize);

    world = MatchComponent(
      resolution: resolution,
      match: match,
    );

    camera = CameraComponent.withFixedResolution(
      width: resolution.x,
      height: resolution.y,
    );

    add(
      FpsTextComponent(
        position: Dimensions.fpsPosition(
          self: match.self,
          viewport: camera.viewport,
        ),
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: camera.viewport.size.y * 0.03,
            color: Colors.white,
          ),
        ),
      ),
    );

    return super.onLoad();
  }
}

mixin GameComponentRef {
  static late GameComponent instance;

  GameComponent get game => instance;
}
