import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/state/game/target.dart';
import 'package:tensionpath/domain/state/game/units/unit_infantry.dart';
import 'package:tensionpath/domain/types/unit_state.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit with GameEngineRef implements Target {
  final Player owner;
  final double maxHealth;
  final double attack;
  final double range;
  final double size;

  late double health;
  late Vector2 position;
  Target? target;
  UnitState state = UnitState.alive;

  Unit({
    required this.maxHealth,
    required this.attack,
    required this.range,
    required this.size,
    required this.owner,
    required Vector2 startingPosition,
  }) {
    health = maxHealth;
    position = Vector2.copy(startingPosition);
  }

  Color get color => owner.color;

  bool get canMove => true;

  @mustCallSuper
  void update(double dt) {
    if (canMove) {
      //position.moveToTarget(nextNode.position, speed * dt);
    }
  }

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
  bool inRange(Unit unit, double range) => true;

  @override
  bool get isAlive => state == UnitState.alive;

  void destroy() {
    // TODO(momo): remove unit from node
    state = UnitState.dead;
  }

  UnitComponent get component;

  factory Unit.fromType({
    required UnitType unitType,
    required Player owner,
    required Node node,
  }) {
    switch (unitType) {
      case UnitType.infantry:
        return UnitInfantry(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          size: node.size.x,
          owner: owner,
          startingPosition: node.position,
        );
    }
  }
}
