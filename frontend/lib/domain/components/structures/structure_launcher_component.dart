import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/utils/assets.dart';

class StructureLauncherComponent extends StructureComponent<StructureLauncher> {
  StructureLauncherComponent({
    required super.structure,
    required super.position,
    required super.size,
  });

  @override
  FutureOr onLoad() async {
    if (structure.player.isPlayer1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_LAUNCHER_1);
    } else if (structure.player.isPlayer2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_LAUNCHER_2);
    }

    return super.onLoad();
  }
}
