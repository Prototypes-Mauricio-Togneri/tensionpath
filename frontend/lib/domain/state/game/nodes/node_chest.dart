import 'package:tensionpath/domain/components/nodes/node_chest_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';

class NodeChest extends Node {
  const NodeChest({
    required super.id,
    required super.lane,
    required super.position,
    required super.size,
  });

  @override
  NodeComponent get component => NodeChestComponent(
        node: this,
        position: position,
        size: size,
      );
}
