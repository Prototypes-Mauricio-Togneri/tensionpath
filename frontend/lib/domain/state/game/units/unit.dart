import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/domain/components/target.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/state/game/units/unit_ranger.dart';
import 'package:tensionpath/domain/state/game/units/unit_shooter.dart';
import 'package:tensionpath/domain/state/game/units/unit_squad.dart';
import 'package:tensionpath/domain/types/unit_state.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit with GameEngineRef implements Target {
  final Player owner;
  final Lane lane;
  final List<Node> nodes;
  final double maxHealth;
  final double speed;
  final double range;
  final double size;

  late double health;
  late int nextNodeIndex;
  late Vector2 position;
  Target? target;
  UnitState state = UnitState.alive;

  Unit({
    required this.maxHealth,
    required this.speed,
    required this.range,
    required this.size,
    required this.owner,
    required this.lane,
    required this.nodes,
    required Vector2 startingPosition,
  }) {
    health = maxHealth;
    nextNodeIndex = 0;
    position = Vector2.copy(startingPosition);
  }

  Color get color => owner.color;

  Node get nextNode => nodes[nextNodeIndex];

  bool get canMove => true;

  @mustCallSuper
  void update(double dt) {
    if (canMove) {
      position.moveToTarget(nextNode.position, speed * dt);
      _checkNextNode();
    }
  }

  void _checkNextNode() {
    if (_hasReached(nextNode) && (nextNodeIndex < (nodes.length - 1))) {
      nextNodeIndex++;
    }
  }

  bool _hasReached(Node node) => (position - node.position).length < 1;

  void reduceHealth(double value) {
    health -= value;
  }

  @override
  void onHit(double damage) {
    health -= damage;

    if (health <= 0) {
      engine.onUnitDestroyed(this);
    }
  }

  @override
  double distance(Unit unit) => (position - unit.position).length;

  @override
  bool get isAlive => state == UnitState.alive;

  void destroy() {
    lane.removeUnit(this);
    state = UnitState.dead;
  }

  UnitComponent get component;

  factory Unit.fromType({
    required UnitType unitType,
    required Player owner,
    required Lane lane,
    required List<Node> nodes,
    required Vector2 startingPosition,
    required double maxUnitSize,
  }) {
    final double maxHealth = unitType.health;
    final double size = unitType.sizeRatio * maxUnitSize;
    final double speed = unitType.speedRatio * size;
    final double range = unitType.rangeRatio * size;

    switch (unitType) {
      case UnitType.ranger:
        return UnitRanger(
          maxHealth: maxHealth,
          speed: speed,
          range: range,
          size: size,
          owner: owner,
          lane: lane,
          nodes: nodes,
          startingPosition: startingPosition,
          weaponType: unitType.weaponType,
        );
      case UnitType.squad:
        return UnitSquad(
          maxHealth: maxHealth,
          speed: speed,
          range: range,
          size: size,
          owner: owner,
          lane: lane,
          nodes: nodes,
          startingPosition: startingPosition,
          weaponType: unitType.weaponType,
        );
      case UnitType.sniper:
      case UnitType.tank:
      case UnitType.kamikaze:
      case UnitType.ion_canon:
        return UnitShooter(
          maxHealth: unitType.health,
          speed: speed,
          range: range,
          size: size,
          owner: owner,
          lane: lane,
          nodes: nodes,
          startingPosition: startingPosition,
          weaponType: unitType.weaponType,
        );
    }
  }
}
