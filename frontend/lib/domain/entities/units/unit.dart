import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit_artillery.dart';
import 'package:tensionpath/domain/entities/units/unit_helicopter.dart';
import 'package:tensionpath/domain/entities/units/unit_humvee.dart';
import 'package:tensionpath/domain/entities/units/unit_rifle_squad.dart';
import 'package:tensionpath/domain/entities/units/unit_sniper.dart';
import 'package:tensionpath/domain/entities/units/unit_tank.dart';
import 'package:tensionpath/domain/types/unit_state.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit {
  final UnitType type;
  final double maxHealth;
  final double attack;
  final double range;
  final Player player;
  late double health;
  UnitState state = UnitState.alive;

  Unit({
    required this.type,
    required this.maxHealth,
    required this.attack,
    required this.range,
    required this.player,
  }) {
    health = maxHealth;
  }

  Color get color => player.color;

  void reduceHealth(double value) {
    health -= value;
  }

  void destroy() {
    state = UnitState.dead;
  }

  UnitComponent component({required Vector2 position, required Vector2 size});

  factory Unit.fromType({required UnitType unitType, required Player player}) {
    switch (unitType) {
      case UnitType.rifle_squad:
        return UnitRifleSquad(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          player: player,
        );
      case UnitType.sniper:
        return UnitSniper(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          player: player,
        );
      case UnitType.humvee:
        return UnitHumvee(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          player: player,
        );
      case UnitType.tank:
        return UnitTank(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          player: player,
        );
      case UnitType.artillery:
        return UnitArtillery(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          player: player,
        );
      case UnitType.helicopter:
        return UnitHelicopter(
          maxHealth: unitType.health,
          attack: unitType.attack,
          range: unitType.range,
          player: player,
        );
    }
  }
}
