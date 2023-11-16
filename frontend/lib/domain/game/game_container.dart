import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/utils/sprites.dart';

class GameContainer extends FlameGame with PanDetector {
  static const double MAP_WIDTH = 1000;

  GameContainer(double screenAspectRatio)
      : super(
          /*camera: CameraComponent.withFixedResolution(
            width: MAP_WIDTH,
            height: MAP_WIDTH / screenAspectRatio,
          ),*/
          world: GameWorld(),
        );

  @override
  void onPanUpdate(DragUpdateInfo info) {
    camera.moveBy(
      Vector2(0, -info.delta.global.y),
      speed: 3000,
    );
  }

  @override
  FutureOr onLoad() {
    camera.setBounds(Rectangle.fromLTWH(
      0,
      1082,
      1000,
      1000,
    ));
    camera.moveTo(Vector2(0, 1082));

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Colors.green;
}

class GameWorld extends World with HasGameRef {
  @override
  Future onLoad() async {
    add(Background(
      size: Vector2(
        gameRef.camera.viewport.size.x,
        gameRef.camera.viewport.size.x * 4.773,
      ),
    ));
    add(Player());
  }
}

class Background extends SpriteComponent {
  Background({super.size})
      : super(
          sprite: Sprites.MAP,
          position: Vector2(0, 0),
          //size: Vector2(gameRef.camera.viewport.size.x, 3165),
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
