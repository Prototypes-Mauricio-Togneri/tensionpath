import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/utils/sprites.dart';

class Battlefield {
  final String id;
  final Sprite sprite;
  final List<Lane> lanes;
  final List<Node> nodes;

  const Battlefield({
    required this.id,
    required this.sprite,
    required this.lanes,
    required this.nodes,
  });

  factory Battlefield.test() => Battlefield(
        id: 'test',
        sprite: Sprites.BATTLEFIELD,
        lanes: [
          //Lane(id: '1', position: Vector2(0, 0), size: Vector2(200, 3000)),
          Lane(id: '2', position: Vector2(100, 0), size: Vector2(200, 3000)),
        ],
        nodes: [
          Node(id: '1', position: Vector2(300, 500)),
          Node(id: '2', position: Vector2(700, 500)),
          Node(id: '3', position: Vector2(100, 1000)),
          Node(id: '4', position: Vector2(900, 1000)),
          Node(id: '5', position: Vector2(500, 1500)),
          Node(id: '6', position: Vector2(100, 2000)),
          Node(id: '7', position: Vector2(900, 2000)),
          Node(id: '8', position: Vector2(300, 2500)),
          Node(id: '9', position: Vector2(700, 2500)),
        ],
      );
}
