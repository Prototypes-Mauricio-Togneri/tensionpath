import 'package:tensionpath/utils/assets.dart';

enum NodeType {
  land(sprite: null),
  water(sprite: Assets.IMAGES_NODES_WATER),
  rock(sprite: Assets.IMAGES_NODES_ROCK);

  final String? sprite;

  bool get canMoveUnit {
    switch (this) {
      case NodeType.land:
        return true;
      case NodeType.water:
      case NodeType.rock:
        return false;
    }
  }

  const NodeType({required this.sprite});
}
