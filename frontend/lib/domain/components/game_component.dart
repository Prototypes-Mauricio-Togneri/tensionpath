import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/utils/palette.dart';

class GameComponent extends FlameGame with PanDetector, HasCollisionDetection {
  final GameState state;
  final double pixelRatio;

  static const double CONTAINER_WIDTH = 1000;
  static const double CONTROLS_HEIGHT = 102;

  GameComponent({
    required this.state,
    required this.pixelRatio,
  }) : super(world: MatchComponent(state));

  double get effectiveScreenHeight =>
      (camera.viewport.size.y * CONTAINER_WIDTH) / camera.viewport.size.x;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    camera.moveBy(
      Vector2(0, -info.delta.global.y * pixelRatio),
      speed: pixelRatio * Constants.PAN_SPEED,
    );
  }

  @override
  FutureOr onLoad() {
    camera = CameraComponent.withFixedResolution(
      width: CONTAINER_WIDTH,
      height: CONTAINER_WIDTH / (size.x / size.y),
    );

    debugMode = false;
    state.setWorld(world);

    final double minCameraY = size.y / 2;
    final double maxCameraY = state.battlefield.mapSize.y - (size.y / 2);

    camera.setBounds(Rectangle.fromLTRB(
      0,
      minCameraY,
      CONTAINER_WIDTH,
      maxCameraY + CONTROLS_HEIGHT,
    ));
    camera.moveTo(Vector2(
      CONTAINER_WIDTH / 2,
      maxCameraY + CONTROLS_HEIGHT,
    ));

    camera.viewport.add(ControlsComponent(
      player: state.self,
      position: Vector2(
        CONTAINER_WIDTH / 2,
        size.y - (CONTROLS_HEIGHT / 2),
      ),
      size: Vector2(
        CONTAINER_WIDTH,
        CONTROLS_HEIGHT,
      ),
      angle: 0,
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
