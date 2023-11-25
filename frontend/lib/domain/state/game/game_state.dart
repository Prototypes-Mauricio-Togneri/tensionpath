import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

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

  void onLauncherSelected(Lane lane, Waypoint waypoint) {
    debugPrint('Clicked lane: ${lane.id}');

    _deployUnit(
      commandPoints: Random().nextInt(10) + 1,
      lane: lane,
      waypoint: waypoint,
    );
  }

  void onUnitCollidedWithBase({
    required Unit unit,
    required String baseOwner,
  }) {
    unit.destroy();
    print('Base of $baseOwner got hit by ${unit.power}');
  }

  void _deployUnit({
    required int commandPoints,
    required Lane lane,
    required Waypoint waypoint,
  }) {
    final Unit unit = Unit.create(
      world: world,
      commandPoints: commandPoints,
      lane: lane,
      waypoint: waypoint,
    );
    world.add(UnitComponent(
      state: this,
      unit: unit,
    ));
  }
}
