import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';

class NodeInvisible extends Node {
  const NodeInvisible({
    required super.id,
    required super.lane,
    required super.position,
    required super.size,
  });

  @override
  NodeComponent get component => NodeComponent(
        node: this,
        position: position,
        size: size,
        rate: 0,
      );
}
