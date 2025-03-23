import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit_infantry.dart';
import 'package:tensionpath/domain/types/unit_state.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit with GameComponentRef {
  final Player owner;
  final double maxHealth;
  final double attack;
  final double range;
  final double size;

  late double health;
  late int x;
  late int y;
  UnitState state = UnitState.alive;

  Unit({
    required this.maxHealth,
    required this.attack,
    required this.range,
    required this.size,
    required this.owner,
    required this.x,
    required this.y,
  }) {
    health = maxHealth;
  }

  Color get color => owner.color;

  Vector2 get position =>
      Vector2((size * x) + (size / 2), (size * y) + (size / 2));

  @mustCallSuper
  void update(double dt) {}

  void reduceHealth(double value) {
    health -= value;
  }

  void destroy() {
    state = UnitState.dead;
  }

  UnitComponent get component;

  factory Unit.fromType({
    required UnitType unitType,
    required Player owner,
    required Node node,
    required double size,
  }) {
    //switch (unitType) {
    //case UnitType.rifle_squad:
    return UnitInfantry(
      maxHealth: unitType.health,
      attack: unitType.attack,
      range: unitType.range,
      size: size,
      owner: owner,
      x: node.x,
      y: node.y,
    );
    //}
  }
}
