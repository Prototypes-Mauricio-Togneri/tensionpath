import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/structures/structure_pad.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/assets.dart';

class StructurePadComponent extends StructureComponent<StructurePad>
    implements Reconfigurable {
  late final Platform platform;

  StructurePadComponent({
    required super.node,
    required super.structure,
    required super.position,
    required super.size,
  }) {
    platform = match.match.battlefield.platformById(structure.platformId);
  }

  @override
  Future reconfigure() async {
    if (platform.owner == Constants.PLAYER_1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_1);
    } else if (platform.owner == Constants.PLAYER_2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_2);
    } else if (platform.owner == '') {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_CONTESTED);
    } else if (platform.owner == null) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
    }
  }

  @override
  FutureOr onLoad() async {
    await reconfigure();

    return super.onLoad();
  }
}
