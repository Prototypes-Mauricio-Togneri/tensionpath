import 'dart:async';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_accumulator_component.dart';
import 'package:tensionpath/domain/components/nodes/node_icon_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeCreditGeneratorComponent extends NodeAccumulatorComponent {
  NodeCreditGeneratorComponent({
    required super.id,
    required super.position,
    required super.size,
    super.owner,
  }) : super(rate: Constants.NODE_CREDIT_GENERATOR_CAPTURE_RATE);

  @override
  FutureOr onLoad() {
    add(NodeIconComponent(
      sprite: Sprites.NODE_ICON_CREDIT_GENERATOR,
      parent: this,
    ));

    return super.onLoad();
  }

  @override
  void onOwnerAssigned(Player owner) {
    GameState.instance.onNodeCreditsGeneratorCaptured(
      node: this,
      owner: owner,
    );
  }

  @override
  void onOwnerUnassigned(Player owner) {
    GameState.instance.onNodeCreditsGeneratorLost(
      node: this,
      owner: owner,
    );
  }
}
