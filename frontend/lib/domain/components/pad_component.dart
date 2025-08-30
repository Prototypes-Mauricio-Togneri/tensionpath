import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class PadComponent extends SpriteComponent {
  final String platformId;
  String? owner;

  PadComponent({
    required super.position,
    required super.size,
    required this.platformId,
    required this.owner,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       );

  @override
  FutureOr onLoad() async {
    await refresh();
  }

  Future refresh() async {
    if (owner == Constants.PLAYER_1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_1);
    } else if (owner == Constants.PLAYER_2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_2);
    } else if (owner == '') {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_CONTESTED);
    } else if (owner == null) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
    }
  }
}
