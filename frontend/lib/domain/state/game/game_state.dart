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
      _deployUnit(
        commandPoints: commandPointsSelected,
        nodes: battlefield.nodes,
        lane: lane,
      );
    }
  }

  void _deployUnit({
    required int commandPoints,
    required List<Node> nodes,
    required Lane lane,
  }) {
    final Unit unit = Unit.create(
      commandPoints: commandPoints,
      nodes: nodes,
      lane: lane,
    );
    deployUnit?.call(unit);
  }
}
