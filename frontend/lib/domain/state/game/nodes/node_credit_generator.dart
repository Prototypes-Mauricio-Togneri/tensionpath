import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/nodes/node_accumulator.dart';
import 'package:tensionpath/domain/state/game/player.dart';

class NodeCreditGenerator extends NodeAccumulator {
  NodeCreditGenerator({
    required super.id,
    required super.position,
  }) : super(rate: Constants.NODE_CREDIT_GENERATOR_CAPTURE_RATE);

  @override
  bool get canAccumulate => hasOwner;

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
