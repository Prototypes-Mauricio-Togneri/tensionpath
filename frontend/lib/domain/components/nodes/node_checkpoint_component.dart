import 'dart:async';
import 'package:flame/events.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/components/nodes/node_icon_component.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeCheckpointComponent extends NodeCapturableComponent
    with TapCallbacks {
  NodeCheckpointComponent({
    required super.id,
    required super.position,
    required super.size,
    super.owner,
  }) : super(rate: Constants.NODE_CHECKPOINT_CAPTURE_RATE);

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
    if (hasOwner && owner!.hasCreditsSelected) {
      spawnUnitOfPlayer(owner!);
    }
  }
}
