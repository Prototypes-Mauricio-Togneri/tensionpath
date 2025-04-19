import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_pad.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/assets.dart';

class StructurePadComponent extends StructureComponent<StructurePad> {
  String? lastOwner;

  StructurePadComponent({
    required super.structure,
    required super.position,
    required super.size,
  });

  @override
  void update(double dt) {
    super.update(dt);

    final String? currentOwner = owner;

    if (currentOwner != lastOwner) {
      lastOwner = currentOwner;
      _setSprite(lastOwner);
    }
  }

  String? get owner =>
      match.match.battlefield.platformById(structure.platformId).owner;

  Future _setSprite(String? owner) async {
    if (owner == '1') {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_1);
    } else if (owner == '2') {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_2);
    } else if (owner == '') {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_CONTESTED);
    } else if (owner == null) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
    }
  }

  @override
  FutureOr onLoad() async {
    lastOwner = owner;
    await _setSprite(lastOwner);

    return super.onLoad();
  }
}
