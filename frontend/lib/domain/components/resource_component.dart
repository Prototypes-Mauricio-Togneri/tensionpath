import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/json/models/json_resource.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class ResourceComponent extends SpriteComponent {
  late double amountCurrent;
  late double amountMax;
  late double ratio;

  ResourceComponent({
    required super.position,
    required super.size,
    required JsonResource resource,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       ) {
    refresh(resource);
  }

  void refresh(JsonResource resource) {
    amountCurrent = resource.amountCurrent;
    amountMax = resource.amountMax;
    ratio = amountCurrent / amountMax;
  }

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_RESOURCES);
    scale = Vector2(ratio, ratio);

    return super.onLoad();
  }
}
