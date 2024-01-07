import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/priority.dart';

class NodeIconComponent extends SpriteComponent {
  NodeIconComponent({
    required super.sprite,
    required SpriteComponent parent,
  }) : super(
          position: parent.size / 2,
          size: parent.size / 2,
          anchor: Anchor.center,
          priority: Priority.node.value,
        );
}
