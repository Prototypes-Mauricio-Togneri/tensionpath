import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';

class NodeComponent extends PositionComponent {
  final Node node;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.node.value,
        );
}
