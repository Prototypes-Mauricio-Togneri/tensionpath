import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/utils/assets.dart';

class StructureResourcesComponent
    extends StructureComponent<StructureResources> {
  StructureResourcesComponent({
    required super.node,
    required super.structure,
    required super.position,
    required super.size,
  });

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_RESOURCES);

    return super.onLoad();
  }
}
