import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/presentation/dialogs/confirmation_dialog.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';

class GameComponent extends FlameGame {
  final MatchState state;
  final Match match;

  GameComponent({required this.state, required this.match}) : super() {
    GameComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    debugMode = false;

    final Size resolution = Dimensions.cameraSize(canvasSize);

    world = MatchComponent(resolution: resolution, match: match);

    camera = CameraComponent.withFixedResolution(
      width: resolution.width,
      height: resolution.height,
    );

    add(
      FpsTextComponent(
        position: Vector2(
          match.player1.isSelf ? (camera.viewport.size.x - 90) : 20,
          camera.viewport.size.y - 40,
        ),
      ),
    );

    match.listen();

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

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
