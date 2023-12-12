import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node_capturable.dart';

class NodeCheckpoint extends NodeCapturable {
  NodeCheckpoint({
    required super.id,
    required super.position,
  }) : super(rate: Constants.NODE_CHECKPOINT_CAPTURE_RATE);
}
