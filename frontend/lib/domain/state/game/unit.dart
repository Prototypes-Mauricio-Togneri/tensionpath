import 'package:flame/game.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/specs/unit_specs.dart';

class Unit {
  final Player owner;
  final List<Node> nodes;
  late int nextNodeIndex;
  late int hp;
  late double speed;
  late Vector2 position;

  Unit({
    required UnitSpecs specs,
    required this.owner,
    required this.nodes,
    required Vector2 startingPosition,
  }) {
    hp = specs.power;
    speed = specs.speed;
    nextNodeIndex = 0;
    position = Vector2.copy(startingPosition);
  }

  Node get nextNode => nodes[nextNodeIndex];

  void update(double dt) {
    //position.moveToTarget(nextNode.position, speed * dt);
    //_checkNextNode();
  }

  void _checkNextNode() {
    if (_hasReached(nextNode) && (nextNodeIndex < (nodes.length - 1))) {
      nextNodeIndex++;
    }
  }

  bool _hasReached(Node node) => (position - node.position).length < 1;

  void reduceHealth(int value) {
    hp -= value;
  }
}
