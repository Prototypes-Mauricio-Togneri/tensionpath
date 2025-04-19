import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_pad.dart';
import 'package:tensionpath/utils/assets.dart';

class StructurePadComponent extends StructureComponent<StructurePad> {
  StructurePadComponent({
    required super.structure,
    required super.position,
    required super.size,
  });

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);

    return super.onLoad();
  }
}
