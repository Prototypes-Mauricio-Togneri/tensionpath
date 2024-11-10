import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_victory_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class NodeVictory extends Node {
  NodeVictory({
    required super.id,
    required super.lane,
    required super.position,
    required super.laneSize,
  }) : super(captureRate: Constants.NODE_VICTORY_CAPTURE_RATE);

  @override
  NodeComponent get component => NodeVictoryComponent(
        node: this,
        position: position,
        size: size,
      );

  @override
  void onOwnerAssigned(Player owner) => state.onNodeVictoryCaptured(this);
}
