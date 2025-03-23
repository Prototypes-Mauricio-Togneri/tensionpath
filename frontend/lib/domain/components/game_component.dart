import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/presentation/dialogs/confirmation_dialog.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';

class GameComponent extends FlameGame {
  final MatchState state;
  final Player self;
  final Player enemy;
  final Battlefield battlefield;

  GameComponent({
    required this.state,
    required this.self,
    required this.enemy,
    required this.battlefield,
  }) : super() {
    GameComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    debugMode = false;

    world = MatchComponent(
      resolution: resolution,
      self: self,
      enemy: enemy,
      battlefield: battlefield,
    );

    camera = CameraComponent.withFixedResolution(
      width: resolution.width,
      height: resolution.height,
    );

    if (debugMode) {
      add(FpsTextComponent());
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

  Size get resolution => Size(
    Constants.UI_WIDTH,
    (canvasSize.y * Constants.UI_WIDTH / canvasSize.x).round().toDouble(),
  );

  @override
  void update(double dt) {
    super.update(dt);

    self.update(dt);
    enemy.update(dt);
    battlefield.update(dt);
  }

  void onMatchFinished(bool won) {
    pauseEngine();

    if (won) {
      ConfirmationDialog.won(onAccept: _onMatchReset, onCancel: _onMatchQuit);
    } else {
      ConfirmationDialog.lost(onAccept: _onMatchReset, onCancel: _onMatchQuit);
    }
  }

  void _onMatchReset() => state.restart();

  void _onMatchQuit() => Navigation.pop();
}

mixin GameComponentRef {
  static late GameComponent instance;

  GameComponent get game => instance;
}
