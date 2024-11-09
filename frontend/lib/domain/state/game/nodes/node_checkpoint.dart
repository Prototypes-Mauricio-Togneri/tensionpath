import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_checkpoint_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';

class NodeCheckpoint extends Node {
  NodeCheckpoint({
    required super.id,
    required super.lane,
    required super.position,
    required super.size,
  }) : super(captureRate: Constants.NODE_CHECKPOINT_CAPTURE_RATE);

  @override
  NodeComponent get component => NodeCheckpointComponent(
        node: this,
        position: position,
        size: size,
      );
}
