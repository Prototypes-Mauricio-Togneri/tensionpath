import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class RocksLowComponent extends SpriteComponent {
  RocksLowComponent({
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_ROCKS_LOW);
    opacity = 0.5;

    return super.onLoad();
  }
}
