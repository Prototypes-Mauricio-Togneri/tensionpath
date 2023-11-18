import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/utils/sprites.dart';

class Battlefield {
  final String id;
  final int lanes;
  final Sprite sprite;
  final List<Node> nodes;

  const Battlefield({
    required this.id,
    required this.lanes,
    required this.sprite,
    required this.nodes,
  });

  factory Battlefield.test() => Battlefield(
        id: 'test',
        lanes: 5,
        sprite: Sprites.BATTLEFIELD,
        nodes: [],
      );
}
