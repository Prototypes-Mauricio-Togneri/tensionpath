import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';

class LauncherComponent extends SpriteComponent {
  final String playerId;

  LauncherComponent({
    required this.playerId,
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       );

  @override
  FutureOr onLoad() async {
    if (playerId == Constants.PLAYER_1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_LAUNCHER_1);
    } else if (playerId == Constants.PLAYER_2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_LAUNCHER_2);
    }

    return super.onLoad();
  }
}
