import 'dart:async';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_pad.dart';

class StructurePadComponent extends StructureComponent<StructurePad>
    implements Reconfigurable {
  StructurePadComponent({
    required super.structure,
    required super.position,
    required super.size,
  });

  @override
  Future reconfigure() async {
    /*if (platform.owner == Constants.PLAYER_1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_1);
    } else if (platform.owner == Constants.PLAYER_2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_2);
    } else if (platform.owner == '') {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_CONTESTED);
    } else if (platform.owner == null) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
    }*/
  }

  @override
  FutureOr onLoad() async {
    await reconfigure();

    return super.onLoad();
  }
}
