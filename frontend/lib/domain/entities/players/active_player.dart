import 'dart:math';
import 'package:tensionpath/domain/entities/players/player.dart';

class ActivePlayer extends Player {
  late int resourcesTarget;

  ActivePlayer({required super.id, required super.baseResourceRate}) {
    _recalculateResources();
  }

  @override
  void takeAction() {
    /*if (resources >= resourcesTarget) {
      final int laneIndex = Random().nextInt(engine.battlefield.lanes.length);

      engine.onSpawnUnit(
        lane: lane,
        player: this,
        node: lane.nodes.last,
        unitType: UnitType.values[resourcesTarget - 1],
      );

      spendResources(resourcesTarget);

      _recalculateResources();
    }*/
  }

  void _recalculateResources() {
    final int value = Random().nextInt(21) + 1;

    if (value <= 6) {
      resourcesTarget = 1;
    } else if (value <= 11) {
      resourcesTarget = 2;
    } else if (value <= 15) {
      resourcesTarget = 3;
    } else if (value <= 18) {
      resourcesTarget = 4;
    } else if (value <= 20) {
      resourcesTarget = 5;
    } else {
      resourcesTarget = 6;
    }
  }
}
