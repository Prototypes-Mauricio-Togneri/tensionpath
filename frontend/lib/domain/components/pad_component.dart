import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class PadComponent extends SpriteComponent {
  final Platform platform;
  String? latestOwner;

  PadComponent({
    required super.position,
    required super.size,
    required this.platform,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _checkOwnership();
  }

  Future _checkOwnership() async {
    if (latestOwner != platform.owner) {
      latestOwner = platform.owner;

      if (latestOwner == Constants.PLAYER_1) {
        sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_1);
      } else if (latestOwner == Constants.PLAYER_2) {
        sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_2);
      } else if (latestOwner == '') {
        sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_CONTESTED);
      } else if (latestOwner == null) {
        sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
      }
    }
  }
}
