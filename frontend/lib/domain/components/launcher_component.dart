import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/json_location.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';

class LauncherComponent extends SpriteComponent {
  final Player player;
  final JsonLocation location;

  LauncherComponent({
    required super.position,
    required super.size,
    required this.player,
    required this.location,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       );

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  bool belongsTo(Player player) => player.id == this.player.id;

  @override
  FutureOr onLoad() async {
    if (player.isPlayer1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_LAUNCHER_1);
    } else if (player.isPlayer2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_LAUNCHER_2);
    }

    return super.onLoad();
  }
}
