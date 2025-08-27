import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class StructureResourcesComponent extends SpriteComponent {
  StructureResourcesComponent({
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.structure.value);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_RESOURCES);

    return super.onLoad();
  }
}
