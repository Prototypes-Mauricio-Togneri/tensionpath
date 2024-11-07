import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_victory_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';

class NodeVictory extends Node {
  const NodeVictory({
    required super.id,
    required super.lane,
    required super.position,
    required super.size,
  });

  @override
  NodeComponent get component => NodeVictoryComponent(
        node: this,
        position: position,
        size: size,
      );
}
