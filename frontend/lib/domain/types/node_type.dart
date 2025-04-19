import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/utils/assets.dart';

enum NodeType {
  land(sprite: null),
  water(sprite: Assets.IMAGES_NODES_WATER),
  rock(sprite: Assets.IMAGES_NODES_WATER);

  final String? sprite;

  bool canMoveUnit(Unit unit) {
    switch (this) {
      case NodeType.land:
        return true;
      case NodeType.water:
      case NodeType.rock:
        return unit.type.unitClass == UnitClass.air;
    }
  }

  const NodeType({required this.sprite});
}
