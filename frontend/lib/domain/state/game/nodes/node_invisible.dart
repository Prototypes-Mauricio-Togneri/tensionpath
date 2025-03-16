import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';

class NodeInvisible extends Node {
  NodeInvisible({
    required super.x,
    required super.y,
    required super.nodeSize,
  }) : super(captureRate: 0);

  @override
  NodeComponent get component =>
      NodeComponent(node: this, position: position, size: size);
}
