import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit_rifle_squad.dart';
import 'package:tensionpath/domain/entities/units/unit_sniper.dart';
import 'package:tensionpath/domain/types/unit_state.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit with GameComponentRef {
  final Player player;
  final double maxHealth;
  final double attack;
  final double range;

  late double health;
  UnitState state = UnitState.alive;

  Unit({
    required this.maxHealth,
    required this.attack,
    required this.range,
    required this.player,
  }) {
    health = maxHealth;
  }

  Color get color => player.color;

  @mustCallSuper
  void update(double dt) {}

  void reduceHealth(double value) {
    health -= value;
  }

  void destroy() {
    state = UnitState.dead;
  }

  UnitComponent component({required Vector2 position, required Vector2 size});

  factory Unit.fromType({required UnitType unitType, required Player owner}) {
    switch (unitType) {
      case UnitType.rifle_squad:
        return UnitRifleSquad(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          player: owner,
        );
      case UnitType.sniper:
        return UnitSniper(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          player: owner,
        );
      default:
        throw Exception('Unknown unit type: $unitType');
    }
  }
}
