import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_land_componet.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:vector_math/vector_math_64.dart';

class NodeLand extends Node {
  NodeLand({
    required super.x,
    required super.y,
    required super.nodeUnit,
    required super.nodePlayer,
  }) : super(type: NodeType.land);

  @override
  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeLandComponent(node: this, position: position, size: size);
}
