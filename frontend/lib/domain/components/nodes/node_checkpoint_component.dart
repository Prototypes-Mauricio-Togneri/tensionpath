import 'dart:async';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/components/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/components/nodes/node_icon_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_checkpoint.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeCheckpointComponent extends NodeCapturableComponent<NodeCheckpoint>
    with TapCallbacks {
  NodeCheckpointComponent({
    required super.node,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    add(NodeIconComponent(
      sprite: Sprites.NODE_ICON_CHECKPOINT,
      parent: this,
    ));

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (node.hasOwner && node.owner!.hasCreditsSelected) {
      node.spawnUnitOfPlayer(node.owner!);
    }
  }
}
