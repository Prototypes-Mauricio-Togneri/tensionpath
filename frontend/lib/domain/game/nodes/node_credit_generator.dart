import 'dart:async';
import 'package:tensionpath/domain/game/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/game/nodes/node_icon_component.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeCreditGeneratorComponent extends NodeCapturableComponent {
  NodeCreditGeneratorComponent({
    required super.node,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    add(NodeIconComponent(
      sprite: Sprites.NODE_ICON_CREDIT_GENERATOR,
      parent: this,
    ));

    return super.onLoad();
  }
}
