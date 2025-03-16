import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';

class NodeComponent<N extends Node> extends PositionComponent {
  final N node;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);
}
