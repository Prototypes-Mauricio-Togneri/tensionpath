import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/unit.dart';

class GameState {
  final Battlefield battlefield;
  late final World world;
  int commandPointsSelected = 0;

  GameState({
    required this.battlefield,
  });

  void setWorld(World newWorld) {
    world = newWorld;
  }

  void onCommandPointsSelected(int amount) {
    commandPointsSelected = amount;
  }

  void onNodeSelected(Node node) {
    debugPrint('Clicked node: ${node.id}');

    node.onSelect();
  }

  void onLaneSelected(Lane lane) {
    debugPrint('Clicked lane: ${lane.id}');

    if (commandPointsSelected > 0) {
      _deployUnit(
        commandPoints: commandPointsSelected,
        lane: lane,
      );
    }
  }

  void _deployUnit({
    required int commandPoints,
    required Lane lane,
  }) {
    final Unit unit = Unit.create(
      world: world,
      commandPoints: commandPoints,
      lane: lane,
    );
    world.add(UnitComponent(
      state: this,
      unit: unit,
    ));
  }
}
