import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class FogComponent extends SpriteComponent {
  FogComponent({required super.position, required super.size})
    : super(anchor: Anchor.center, priority: Priority.fog.value);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_NODES_FOG);
    decorator.addLast(PaintDecorator.grayscale(opacity: 0.5));

    return super.onLoad();
  }
}
