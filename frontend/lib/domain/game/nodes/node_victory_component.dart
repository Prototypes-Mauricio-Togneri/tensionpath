import 'dart:async';
import 'package:tensionpath/domain/game/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/game/nodes/node_icon_component.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeVictoryComponent extends NodeCapturableComponent {
  NodeVictoryComponent({
    required super.node,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    add(NodeIconComponent(
      sprite: Sprites.NODE_ICON_VICTORY,
      parent: this,
    ));

    return super.onLoad();
  }
}
