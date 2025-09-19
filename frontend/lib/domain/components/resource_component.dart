import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class ResourceComponent extends SpriteComponent {
  late num amountCurrent;
  late num amountMax;
  late num ratio;

  ResourceComponent({
    required super.position,
    required super.size,
    required Resources resources,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       ) {
    refresh(resources);
  }

  void refresh(Resources resources) {
    amountCurrent = resources.amountCurrent;
    amountMax = resources.amountMax;
    ratio = amountCurrent / amountMax;
  }

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_RESOURCES);
    scale = Vector2(ratio.toDouble(), ratio.toDouble());

    return super.onLoad();
  }
}
