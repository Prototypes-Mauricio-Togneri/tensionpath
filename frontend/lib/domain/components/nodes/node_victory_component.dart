import 'dart:async';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/components/nodes/node_icon_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeVictoryComponent extends NodeCapturableComponent {
  NodeVictoryComponent({
    required super.id,
    required super.position,
    required super.size,
    super.owner,
  }) : super(rate: Constants.NODE_VICTORY_CAPTURE_RATE);

  @override
  FutureOr onLoad() {
    add(NodeIconComponent(
      sprite: Sprites.NODE_ICON_VICTORY,
      parent: this,
    ));

    return super.onLoad();
  }

  @override
  void onOwnerAssigned(Player owner) =>
      GameState.instance.onNodeVictoryCaptured(this);
}
