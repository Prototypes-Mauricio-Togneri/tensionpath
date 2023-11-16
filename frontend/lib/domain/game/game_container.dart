import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/utils/sprites.dart';

class GameContainer extends FlameGame with ScrollDetector {
  static const double MAP_WIDTH = 1000;

  GameContainer(double screenAspectRatio)
      : super(
          camera: CameraComponent.withFixedResolution(
            width: MAP_WIDTH,
            height: MAP_WIDTH / screenAspectRatio,
          ),
          world: GameWorld(),
        );

  @override
  void onScroll(PointerScrollInfo info) {
    print(info);
    camera.moveBy(Vector2(0, info.scrollDelta.global.y * 5));
  }

  @override
  FutureOr onLoad() {
    camera.moveTo(Vector2(500, 1082));

    return super.onLoad();
  }
}

class GameWorld extends World {
  @override
  Future onLoad() async {
    add(Background());
    add(Player());
  }
}

class Background extends SpriteComponent {
  Background()
      : super(
          sprite: Sprites.MAP,
          position: Vector2(0, 0),
          size: Vector2(1000, 3165),
          anchor: Anchor.topLeft,
          priority: -1,
        );
}

class Player extends SpriteComponent {
  Player()
      : super(
          sprite: Sprites.PLAYER,
          position: Vector2(100, 100),
          size: Vector2(150, 210),
          anchor: Anchor.center,
        );
}
