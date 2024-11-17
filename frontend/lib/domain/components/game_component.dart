import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/lane_component.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/components/nodes/node_checkpoint_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/utils/palette.dart';

class GameComponent extends FlameGame with HasCollisionDetection {
  final GameState state;
  final List<LaneComponent> cachedLaneComponents = [];
  final List<NodeComponent> cachedNodeComponents = [];

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

  Iterable<NodeComponent> get nodeComponents {
    if (cachedNodeComponents.isEmpty) {
      final BattlefieldComponent battlefieldComponent =
          world.children.whereType<BattlefieldComponent>().first;
      cachedNodeComponents.addAll(
          battlefieldComponent.children.whereType<NodeCheckpointComponent>());
    }

    return cachedNodeComponents;
  }

  Lane? checkLaneHover(Vector2 position) {
    Lane? result;

    for (final LaneComponent lane in laneComponents) {
      final Lane? laneResult = lane.checkHover(position);

      if (laneResult != null) {
        result = laneResult;
      }
    }

    return result;
  }

  Node? checkNodeHover(Vector2 position) {
    Node? result;

    for (final NodeComponent node in nodeComponents) {
      final Node? nodeResult = node.checkHover(position);

      if (nodeResult != null) {
        result = nodeResult;
      }
    }

    return result;
  }

  void cleanHover() {
    for (final LaneComponent lane in laneComponents) {
      lane.cleanHover();
    }

    for (final NodeComponent node in nodeComponents) {
      node.cleanHover();
    }
  }

  @override
  void update(double dt) {
    state.update(dt);

    super.update(dt);
  }
}
