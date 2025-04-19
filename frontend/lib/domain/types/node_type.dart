import 'package:tensionpath/utils/assets.dart';

enum NodeType {
  land(sprite: null),
  water(sprite: Assets.IMAGES_NODES_WATER),
  rock(sprite: Assets.IMAGES_NODES_WATER);

  final String? sprite;

  const NodeType({required this.sprite});
}
