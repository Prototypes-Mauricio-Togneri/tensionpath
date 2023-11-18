import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/unit.dart';

class GameState {
  final Battlefield battlefield;
  int commandPointsSelected = 0;
  Function(Unit)? deployUnit;

  GameState({
    required this.battlefield,
  });

  void setCallbacks(Function(Unit) deploy) {
    deployUnit = deploy;
  }

  void onCommandPointsSelected(int amount) {
    commandPointsSelected = amount;
  }

  void onNodeSelected(Node node) {
    debugPrint('Clicked node: ${node.id}');
  }

  void onLaneSelected(Lane lane) {
    debugPrint('Clicked lane: ${lane.id}');

    if (commandPointsSelected > 0) {
      _deployUnit(commandPointsSelected, lane);
    }
  }

  void _deployUnit(int cp, Lane lane) {
    final Unit unit = Unit(
      power: cp,
      speed: 200,
      position: Vector2(lane.position.x + 100, 3000),
    );
    deployUnit?.call(unit);
  }
}
