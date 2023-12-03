import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/types/priority.dart';

class NodeBaseLauncherComponent extends SpriteComponent {
  final Node node;

  NodeBaseLauncherComponent({
    required this.node,
    required super.size,
  }) : super(
          sprite: node.sprite,
          position: node.position,
          anchor: Anchor.center,
          priority: Priority.nodes.value,
        );
}
