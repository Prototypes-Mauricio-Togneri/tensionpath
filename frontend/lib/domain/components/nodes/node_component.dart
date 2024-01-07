import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';

class NodeComponent<T extends Node> extends SpriteComponent {
  final T node;

  NodeComponent({
    required this.node,
    required super.size,
  }) : super(
          sprite: node.sprite,
          position: node.position,
          anchor: Anchor.center,
          priority: Priority.node.value,
        );
}
