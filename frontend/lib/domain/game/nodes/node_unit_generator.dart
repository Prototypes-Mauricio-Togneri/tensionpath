import 'dart:async';
import 'package:tensionpath/domain/game/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/game/nodes/node_icon_component.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeUnitGeneratorComponent extends NodeCapturableComponent {
  NodeUnitGeneratorComponent({
    required super.node,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    add(NodeIconComponent(
      sprite: Sprites.NODE_ICON_UNIT_GENERATOR,
      parent: this,
    ));

    return super.onLoad();
  }
}
