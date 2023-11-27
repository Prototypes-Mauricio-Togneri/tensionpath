import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class GameState {
  final Player self;
  final Player enemy;
  final Battlefield battlefield;
  late final World world;
  int commandPointsSelected = 0;

  GameState({
    required this.self,
    required this.enemy,
    required this.battlefield,
  });

  void setWorld(World newWorld) {
    world = newWorld;
  }

  void update(double dt) {
    self.update(dt);
    enemy.update(dt);

    battlefield.nodes.forEach((node) => node.update(dt));
  }

  void onCommandPointsSelected(int amount) {
    commandPointsSelected = amount;
  }

  void onLauncherSelected(Lane lane, Player owner) {
    debugPrint('Clicked lane: ${lane.id}');

    _deployUnit(
      owner: owner,
      power: Random().nextInt(10) + 1,
      waypoints: lane.getWaypoints(owner.isSelf),
    );
  }

  void onUnitCollidedWithBase({
    required Unit unit,
    required Player baseOwner,
  }) {
    unit.destroy();
    debugPrint('Base of ${baseOwner.id} got hit by ${unit.power}');
  }

  void onNodeCaptured({
    required Node node,
    required Player? previousOwner,
    required Player newOwner,
  }) {
    switch (node.type) {
      case NodeType.victory:
      // TODO: Handle this case.
      case NodeType.chest:
        _onNodeChestCaptured(
          node: node,
          newOwner: newOwner,
        );
      case NodeType.command_point_generator:
        _onNodeCommandPointGeneratorCaptured(
          node: node,
          previousOwner: previousOwner,
          newOwner: newOwner,
        );
      case NodeType.unit_generator:
      // TODO: Handle this case.
      case NodeType.checkpoint:
      // TODO: Handle this case.
    }
  }

  void _onNodeCommandPointGeneratorCaptured({
    required Node node,
    required Player? previousOwner,
    required Player newOwner,
  }) {
    const double extra = Constants.COMMAND_POINTS_EXTRA_RATIO;
    newOwner.addCommandPointsExtraRatio(extra);
    previousOwner?.removeCommandPointsExtraRatio(extra);
  }

  void _onNodeChestCaptured({
    required Node node,
    required Player newOwner,
  }) {
    newOwner.addCommandPoints(node.commandPointsAccumulated);
  }

  void _deployUnit({
    required Player owner,
    required int power,
    required List<Waypoint> waypoints,
  }) {
    final Unit unit = Unit.create(
      owner: owner,
      world: world,
      power: power,
      waypoints: waypoints,
    );
    world.add(UnitComponent(
      state: this,
      unit: unit,
    ));
  }
}
