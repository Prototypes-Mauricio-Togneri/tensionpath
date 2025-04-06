import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/utils/assets.dart';

class StructureMissileComponent extends StructureComponent<StructureMissile> {
  StructureMissileComponent({
    required super.structure,
    required super.position,
    required super.size,
  });

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_MISSILE);

    return super.onLoad();
  }
}
