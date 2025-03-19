import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_victory_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';

class NodeVictory extends Node {
  NodeVictory({required super.x, required super.y});

  @override
  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeVictoryComponent(node: this, position: position, size: size);
}
