import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class GameContainer extends FlameGame {
  GameContainer()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 1000,
            height: 1770,
          ),
          world: GameWorld(),
        );
}

class GameWorld extends World with HasGameReference {
  @override
  Future onLoad() async {
    final Sprite sprite = await game.loadSprite('player.png');

    add(Background());
    add(Player(sprite: sprite));
  }
}

class Background extends PositionComponent {
  @override
  int priority = -1;

  late Paint backgroundColor;
  late final Rect hugeRect;

  Background()
      : super(
          size: Vector2.all(100000),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    backgroundColor = BasicPalette.red.paint();
    hugeRect = size.toRect();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(hugeRect, backgroundColor);
  }
}

class Player extends SpriteComponent {
  Player({super.sprite})
      : super(
          size: Vector2(149, 211),
          anchor: Anchor.center,
        );
}
