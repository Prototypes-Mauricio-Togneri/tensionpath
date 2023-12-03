import 'package:tensionpath/domain/game/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/game/nodes/node_icon_component.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeCommandPointsGeneratorComponent extends NodeCapturableComponent {
  NodeCommandPointsGeneratorComponent({
    required super.node,
    required super.size,
  });

  @override
  Future onLoad() {
    add(NodeIconComponent(
      sprite: Sprites.NODE_ICON_GENERATOR,
      parent: this,
    ));

    return super.onLoad();
  }
}
