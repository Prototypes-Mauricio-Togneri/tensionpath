import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/structures/structure_pad.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/assets.dart';

class StructurePadComponent extends StructureComponent<StructurePad> {
  late final Platform platform;
  String? lastOwner;

  StructurePadComponent({
    required super.structure,
    required super.position,
    required super.size,
  }) {
    platform = match.match.battlefield.platformById(structure.platformId);
    lastOwner = platform.owner;
  }

  // TODO(momo): implement
  void reconfigure() {}

  @override
  void update(double dt) {
    super.update(dt);

    final String? currentOwner = platform.owner;

    if (currentOwner != lastOwner) {
      lastOwner = currentOwner;
      _setSprite(lastOwner);
    }
  }

  Future _setSprite(String? owner) async {
    if (owner == Constants.PLAYER_1) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_1);
    } else if (owner == Constants.PLAYER_2) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_PLAYER_2);
    } else if (owner == '') {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_CONTESTED);
    } else if (owner == null) {
      sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_PAD_NEUTRAL);
    }
  }

  @override
  FutureOr onLoad() async {
    await _setSprite(lastOwner);

    return super.onLoad();
  }
}
