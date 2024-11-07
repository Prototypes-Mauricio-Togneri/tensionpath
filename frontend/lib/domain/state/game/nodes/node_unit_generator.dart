import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_unit_generator.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';

class NodeUnitGenerator extends Node {
  const NodeUnitGenerator({
    required super.id,
    required super.lane,
    required super.position,
    required super.size,
  });

  @override
  NodeComponent get component => NodeUnitGeneratorComponent(
        node: this,
        position: position,
        size: size,
      );
}
