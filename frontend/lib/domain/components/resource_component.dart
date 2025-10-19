import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class ResourceComponent extends SpriteComponent with HasVisibility {
  final Resources resources;

  ResourceComponent({
    required super.position,
    required super.size,
    required this.resources,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_RESOURCES);
    opacity = 0.5;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    isVisible = resources.hasResources;
  }
}
