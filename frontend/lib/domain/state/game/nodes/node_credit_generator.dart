import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_credit_generator.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';

class NodeCreditGenerator extends Node {
  const NodeCreditGenerator({
    required super.id,
    required super.lane,
    required super.position,
    required super.size,
  });

  @override
  NodeComponent get component => NodeCreditGeneratorComponent(
        node: this,
        position: position,
        size: size,
      );
}
