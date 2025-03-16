import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_victory_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';

class NodeVictory extends Node {
  NodeVictory({required super.x, required super.y, required super.nodeSize});

  @override
  NodeComponent get component =>
      NodeVictoryComponent(node: this, position: position, size: size);
}
