import 'dart:math';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/nodes/node_checkpoint.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class ActivePlayer extends Player {
  late int creditsTarget;

  ActivePlayer({
    required super.id,
    required super.ownershipDirection,
  }) {
    _recalculateCredits();
  }

  @override
  void takeAction() {
    if (credits >= creditsTarget) {
      final GameState state = GameState.instance;
      final int laneIndex = Random().nextInt(state.battlefield.lanes.length);
      final Lane lane = state.battlefield.lanes[laneIndex];
      final List<Node> nodes =
          lane.nodesFromPlayer(this).whereType<NodeCheckpoint>().toList();

      if (nodes.isNotEmpty) {
        state.onSpawnUnit(
          lane: lane,
          player: this,
          node: nodes[Random().nextInt(nodes.length)],
          power: creditsTarget,
        );
      } else {
        state.onSpawnUnit(
          lane: lane,
          player: this,
          node: lane.nodes.last,
          power: creditsTarget,
        );
      }

      spendCredits(creditsTarget);

      _recalculateCredits();
    }
  }

  void _recalculateCredits() {
    creditsTarget = Random().nextInt(10) + 1;
  }
}
