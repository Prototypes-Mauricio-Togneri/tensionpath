import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_missile_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class NodeMissile extends Node {
  NodeMissile({
    required super.x,
    required super.y,
    required super.nodeUnit,
    required super.nodeStructure,
  }) : super(type: NodeType.missile);

  @override
  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeMissileComponent(node: this, position: position, size: size);
}
