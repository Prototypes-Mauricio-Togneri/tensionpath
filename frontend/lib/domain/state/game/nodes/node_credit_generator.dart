import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node_accumulator.dart';
import 'package:tensionpath/domain/state/game/player.dart';

class NodeCreditGenerator extends NodeAccumulator {
  NodeCreditGenerator({
    required super.id,
    required super.position,
  }) : super(rate: Constants.NODE_CREDIT_GENERATOR_CAPTURE_RATE);

  @override
  void onNewOwner({
    required Player? previousOwner,
    required Player newOwner,
  }) {
    state.onNodeCreditsGeneratorCaptured(
      node: this,
      previousOwner: previousOwner,
      newOwner: newOwner,
    );
  }
}
