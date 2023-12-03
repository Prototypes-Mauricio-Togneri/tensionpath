import 'package:tensionpath/domain/state/game/nodes/node_accumulator.dart';
import 'package:tensionpath/domain/state/game/nodes/node_capturable.dart';
import 'package:tensionpath/domain/state/game/player.dart';

class NodeCreditGenerator extends NodeCapturable with NodeAccumulator {
  NodeCreditGenerator({
    required super.id,
    required super.position,
  }) : super(rate: 0.1);

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

  @override
  bool update(double dt) {
    if (hasOwner) {
      accumulate(dt);
    }

    return super.update(dt);
  }
}
