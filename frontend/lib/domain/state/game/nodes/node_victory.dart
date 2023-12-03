import 'package:tensionpath/domain/state/game/nodes/node_capturable.dart';
import 'package:tensionpath/domain/state/game/player.dart';

class NodeVictory extends NodeCapturable {
  NodeVictory({
    required super.id,
    required super.position,
  }) : super(rate: 0.01);

  @override
  void onNewOwner({
    required Player? previousOwner,
    required Player newOwner,
  }) =>
      state.onNodeVictoryCaptured(this);
}
