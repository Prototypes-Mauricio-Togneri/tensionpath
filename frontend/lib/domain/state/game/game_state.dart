import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
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

  void onLauncherSelected(Lane lane, Waypoint waypoint, String owner) {
    debugPrint('Clicked lane: ${lane.id}');

    _deployUnit(
      owner: owner,
      power: Random().nextInt(10) + 1,
      waypoints: lane.getWaypoints(owner == Constants.PLAYER_SELF),
      startingPosition: waypoint.position,
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
    required String owner,
    required int power,
    required List<Waypoint> waypoints,
    required Vector2 startingPosition,
  }) {
    final Unit unit = Unit.create(
      owner: owner,
      world: world,
      power: power,
      waypoints: waypoints,
      startingPosition: startingPosition,
    );
    world.add(UnitComponent(
      state: this,
      unit: unit,
    ));
  }
}
