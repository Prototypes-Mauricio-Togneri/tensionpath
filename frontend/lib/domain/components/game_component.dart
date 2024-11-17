import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/lane_component.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/utils/palette.dart';

class GameComponent extends FlameGame with HasCollisionDetection {
  final GameState state;
  final List<LaneComponent> cachedLaneComponents = [];

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

    if (debugMode) {
      add(FpsTextComponent());
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

  Iterable<LaneComponent> get laneComponents {
    if (cachedLaneComponents.isEmpty) {
      final BattlefieldComponent battlefieldComponent =
          world.children.whereType<BattlefieldComponent>().first;
      cachedLaneComponents
          .addAll(battlefieldComponent.children.whereType<LaneComponent>());
    }

    return cachedLaneComponents;
  }

  Lane? checkHover(Vector2 position) {
    Lane? result;

    for (final LaneComponent lane in laneComponents) {
      result ??= lane.checkHover(position);
    }

    return result;
  }

  void cleanHover() {
    for (final LaneComponent lane in laneComponents) {
      lane.cleanHover();
    }
  }

  @override
  void update(double dt) {
    state.update(dt);

    super.update(dt);
  }
}
