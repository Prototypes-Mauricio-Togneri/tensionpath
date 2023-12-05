import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node_accumulator.dart';

class NodeChest extends NodeAccumulator {
  NodeChest({
    required super.id,
    required super.position,
  }) : super(rate: Constants.NODE_CHEST_CAPTURE_RATE);

  void onAcquired() {
    state.onAddCredits(
      player: owner!,
      credits: creditsAccumulated,
    );

    removeAccumulated(creditsAccumulated);
  }
}
