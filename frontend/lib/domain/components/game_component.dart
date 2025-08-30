import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/presentation/dialogs/info_dialog.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/navigation.dart';

class GameComponent extends FlameGame {
  final JsonMatch match;

  GameComponent(this.match) {
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
        position: Dimensions.fpsPosition(camera.viewport),
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

  void onMatchFinished(bool won) {
    if (won) {
      InfoDialog.won(_onMatchQuit);
    } else {
      InfoDialog.lost(_onMatchQuit);
    }
  }

  void _onMatchQuit() => Navigation.pop();
}

mixin GameComponentRef {
  static late GameComponent instance;

  GameComponent get game => instance;
}
