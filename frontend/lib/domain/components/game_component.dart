import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/base_indicator_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/utils/palette.dart';

class GameComponent extends FlameGame with PanDetector, HasCollisionDetection {
  final GameState state;
  final double pixelRatio;

  GameComponent({
    required this.state,
    required this.pixelRatio,
  }) : super(world: MatchComponent(state));

  @override
  void onPanUpdate(DragUpdateInfo info) {
    camera.moveBy(
      Vector2(0, -info.delta.global.y * pixelRatio),
      speed: pixelRatio * Constants.PAN_SPEED,
    );
  }

  @override
  FutureOr onLoad() {
    final Battlefield battlefield = state.battlefield;
    final double mapWidth = battlefield.mapSize.x;

    camera = CameraComponent.withFixedResolution(
      width: mapWidth,
      height: mapWidth / (size.x / size.y),
    );

    debugMode = false;
    state.setGameComponent(this);

    final double minCameraY = size.y / 2;
    final double maxCameraY = state.battlefield.mapSize.y - (size.y / 2);

    camera.setBounds(Rectangle.fromLTRB(
      0,
      minCameraY - Constants.BASE_HEIGHT,
      mapWidth,
      maxCameraY + Constants.BASE_HEIGHT + Constants.CONTROLS_HEIGHT,
    ));

    camera.moveTo(Vector2(
      mapWidth / 2,
      maxCameraY + Constants.BASE_HEIGHT + Constants.CONTROLS_HEIGHT,
    ));

    camera.viewport.add(ControlsComponent(
      player: state.self,
      position: Vector2(
        mapWidth / 2,
        size.y - (Constants.CONTROLS_HEIGHT / 2),
      ),
      size: Vector2(
        mapWidth,
        Constants.CONTROLS_HEIGHT,
      ),
    ));

    camera.viewport.add(BaseIndicatorComponent(
      base: battlefield.baseSelf,
      position: Vector2(
        mapWidth / 2,
        size.y - Constants.CONTROLS_HEIGHT - (Constants.BASE_HEIGHT / 2),
      ),
      size: Vector2(
        mapWidth,
        Constants.BASE_HEIGHT,
      ),
    ));

    camera.viewport.add(BaseIndicatorComponent(
      base: battlefield.baseEnemy,
      position: Vector2(
        mapWidth / 2,
        Constants.BASE_HEIGHT / 2,
      ),
      size: Vector2(
        mapWidth,
        Constants.BASE_HEIGHT,
      ),
    ));

    if (debugMode) {
      add(FpsTextComponent());
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Palette.black;

  @override
  void update(double dt) {
    state.update(dt);

    super.update(dt);
  }
}
