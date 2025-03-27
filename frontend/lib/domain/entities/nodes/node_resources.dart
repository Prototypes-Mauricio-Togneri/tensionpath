import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_resources_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:vector_math/vector_math_64.dart';

class NodeResources extends Node {
  NodeResources({required super.x, required super.y})
    : super(type: NodeType.resources);

  @override
  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeResourcesComponent(node: this, position: position, size: size);
}
