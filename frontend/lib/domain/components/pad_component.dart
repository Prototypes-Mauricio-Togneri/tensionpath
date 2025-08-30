import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class PadComponent extends SpriteComponent {
  final String platformId;

  PadComponent({
    required this.platformId,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.structure.value);

  Future reconfigure() async {
    /*if (platform.owner == Constants.PLAYER_1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_1);
    } else if (platform.owner == Constants.PLAYER_2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_2);
    } else if (platform.owner == '') {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_CONTESTED);
    } else if (platform.owner == null) {*/
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
    //}
  }

  @override
  FutureOr onLoad() async {
    await reconfigure();

    return super.onLoad();
  }
}
