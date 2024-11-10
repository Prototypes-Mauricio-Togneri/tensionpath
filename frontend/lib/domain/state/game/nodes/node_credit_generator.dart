import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_credit_generator_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class NodeCreditGenerator extends Node {
  NodeCreditGenerator({
    required super.id,
    required super.lane,
    required super.position,
    required super.laneSize,
  }) : super(captureRate: Constants.NODE_CREDIT_GENERATOR_CAPTURE_RATE);

  @override
  NodeComponent get component => NodeCreditGeneratorComponent(
        node: this,
        position: position,
        size: size,
      );

  @override
  void onOwnerAssigned(Player owner) {
    state.onNodeCreditsGeneratorCaptured(
      node: this,
      owner: owner,
    );
  }

  @override
  void onOwnerUnassigned(Player owner) {
    state.onNodeCreditsGeneratorLost(
      node: this,
      owner: owner,
    );
  }
}
