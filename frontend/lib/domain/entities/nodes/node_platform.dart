import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_platform.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class NodePlatform extends Node {
  NodePlatform({
    required super.x,
    required super.y,
    required super.nodeUnit,
    required super.nodeStructure,
  }) : super(type: NodeType.platform);

  @override
  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodePlatformComponent(node: this, position: position, size: size);
}
