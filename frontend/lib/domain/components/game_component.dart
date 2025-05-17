import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/presentation/dialogs/info_dialog.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/navigation.dart';

class GameComponent extends FlameGame with KeyboardEvents {
  final MatchState state;
  final Match match;
  StreamSubscription? _matchSubscription;

  GameComponent({required this.state, required this.match}) : super() {
    GameComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    final Size resolution = Dimensions.cameraSize(canvasSize);

    world = MatchComponent(resolution: resolution, match: match);

    camera = CameraComponent.withFixedResolution(
      width: resolution.width,
      height: resolution.height,
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

    _matchSubscription = match.listen();

    return super.onLoad();
  }

  @override
  void onRemove() {
    _matchSubscription?.cancel();
    _matchSubscription = null;

    super.onRemove();
  }

  void onMatchFinished(bool won) {
    if (won) {
      InfoDialog.won(_onMatchQuit);
    } else {
      InfoDialog.lost(_onMatchQuit);
    }
  }

  void _onMatchQuit() => Navigation.pop();

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        match.onEndTurn();
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }
}

mixin GameComponentRef {
  static late GameComponent instance;

  GameComponent get game => instance;
}
