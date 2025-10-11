import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class PadComponent extends SpriteComponent {
  final Platform platform;
  String? lastOwner;
  late final Sprite neutralSprite;
  late final Sprite contestedSprite;
  late final Sprite player1Sprite;
  late final Sprite player2Sprite;

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
    neutralSprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
    contestedSprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_CONTESTED);
    player1Sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_1);
    player2Sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_2);

    sprite = neutralSprite;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _checkOwnership();
  }

  void _checkOwnership() {
    if (lastOwner != platform.owner) {
      lastOwner = platform.owner;

      if (lastOwner == Constants.PLAYER_1) {
        sprite = player1Sprite;
      } else if (lastOwner == Constants.PLAYER_2) {
        sprite = player2Sprite;
      } else if (lastOwner == '') {
        sprite = contestedSprite;
      } else if (lastOwner == null) {
        sprite = neutralSprite;
      }
    }
  }
}
