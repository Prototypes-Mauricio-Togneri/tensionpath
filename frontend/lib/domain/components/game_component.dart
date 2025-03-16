import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/presentation/dialogs/confirmation_dialog.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';

class GameComponent extends FlameGame with GameEngineRef {
  final MatchState matchState;

  GameComponent(this.matchState) : super(world: MatchComponent());

  @override
  FutureOr onLoad() {
    debugMode = false;

    camera = CameraComponent.withFixedResolution(
      height: Constants.SCREEN_HEIGHT,
      width: Constants.SCREEN_WIDTH,
    );

    camera.moveTo(
      Vector2(Constants.SCREEN_WIDTH / 2, Constants.SCREEN_HEIGHT / 2),
    );

    if (debugMode) {
      add(FpsTextComponent());
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

  Iterable<UnitComponent> get unitComponents =>
      world.children.whereType<UnitComponent>();

  void onUnitCreated(UnitComponent unitComponent) {
    world.add(unitComponent);
  }

  void onUnitDestroyed(Unit unit) {
    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.unit == unit) {
        world.remove(unitComponent);
        break;
      }
    }
  }

  @override
  void update(double dt) {
    engine.update(dt);

    super.update(dt);
  }

  void onMatchFinished(bool won) {
    pauseEngine();

    if (won) {
      ConfirmationDialog.won(onAccept: _onMatchReset, onCancel: _onMatchQuit);
    } else {
      ConfirmationDialog.lost(onAccept: _onMatchReset, onCancel: _onMatchQuit);
    }
  }

  void _onMatchReset() => matchState.restart();

  void _onMatchQuit() => Navigation.pop();
}
