import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/base_component.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';

class MatchComponent extends World {
  final GameState state;

  MatchComponent(this.state);

  @override
  FutureOr onLoad() {
    add(BattlefieldComponent(state.battlefield));

    add(BaseComponent(
      base: state.battlefield.baseEnemy,
      position: Vector2(0, -Constants.UI_BASE_HEIGHT),
      size: Vector2(
        Constants.SCREEN_WIDTH,
        Constants.UI_BASE_HEIGHT,
      ),
    ));

    add(BaseComponent(
      base: state.battlefield.baseSelf,
      position: Vector2(
        0,
        Constants.SCREEN_HEIGHT -
            Constants.UI_CONTROLS_HEIGHT -
            (Constants.UI_BASE_HEIGHT * 2),
      ),
      size: Vector2(
        Constants.SCREEN_WIDTH,
        Constants.UI_BASE_HEIGHT,
      ),
    ));

    add(ControlsComponent(
      player: state.self,
      position: Vector2(
        0,
        Constants.SCREEN_HEIGHT -
            Constants.UI_CONTROLS_HEIGHT -
            Constants.UI_BASE_HEIGHT,
      ),
      size: Vector2(
        Constants.SCREEN_WIDTH,
        Constants.UI_CONTROLS_HEIGHT,
      ),
    ));

    return super.onLoad();
  }
}
