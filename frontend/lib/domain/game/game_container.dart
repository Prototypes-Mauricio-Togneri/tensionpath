import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/utils/sprites.dart';

class GameContainer extends FlameGame {
  GameContainer()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 1000,
            height: 1777,
          ),
          world: GameWorld(),
        );
}

class GameWorld extends World with HasGameReference {
  @override
  Future onLoad() async {
    add(Background());
    add(Player());
  }
}

class Background extends PositionComponent {
  late final Paint backgroundColor;
  late final Rect hugeRect;

  Background()
      : super(
          size: Vector2.all(100000),
          anchor: Anchor.center,
          priority: -1,
        );

  @override
  Future onLoad() async {
    backgroundColor = BasicPalette.red.paint();
    hugeRect = size.toRect();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(hugeRect, backgroundColor);
  }
}

class Player extends SpriteComponent {
  Player()
      : super(
          sprite: Sprites.PLAYER,
          size: Vector2(149, 211),
          anchor: Anchor.center,
        );
}
