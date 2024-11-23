import 'dart:math';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/nodes/node_checkpoint.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class ActivePlayer extends Player {
  late int creditsTarget;

  ActivePlayer({
    required super.id,
    required super.ownershipDirection,
    required super.baseCreditsRate,
  }) {
    _recalculateCredits();
  }

  @override
  void takeAction() {
    if (credits >= creditsTarget) {
      final int laneIndex = Random().nextInt(engine.battlefield.lanes.length);
      final Lane lane = engine.battlefield.lanes[laneIndex];
      final List<Node> nodes =
          lane.nodesFromPlayer(this).whereType<NodeCheckpoint>().toList();

      if (nodes.isNotEmpty) {
        engine.onSpawnUnit(
          lane: lane,
          player: this,
          node: nodes[Random().nextInt(nodes.length)],
          unitType: UnitType.values[creditsTarget - 1],
        );
      } else {
        engine.onSpawnUnit(
          lane: lane,
          player: this,
          node: lane.nodes.last,
          unitType: UnitType.values[creditsTarget - 1],
        );
      }

      spendCredits(creditsTarget);

      _recalculateCredits();
    }
  }

  void _recalculateCredits() {
    final int value = Random().nextInt(21) + 1;

    if (value <= 6) {
      creditsTarget = 1;
    } else if (value <= 11) {
      creditsTarget = 2;
    } else if (value <= 15) {
      creditsTarget = 3;
    } else if (value <= 18) {
      creditsTarget = 4;
    } else if (value <= 20) {
      creditsTarget = 5;
    } else {
      creditsTarget = 6;
    }
  }
}
