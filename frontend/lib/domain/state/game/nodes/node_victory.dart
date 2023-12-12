import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node_capturable.dart';
import 'package:tensionpath/domain/state/game/player.dart';

class NodeVictory extends NodeCapturable {
  NodeVictory({
    required super.id,
    required super.position,
  }) : super(rate: Constants.NODE_VICTORY_CAPTURE_RATE);

  @override
  void onOwnerAssigned(Player owner) => state.onNodeVictoryCaptured(this);
}
