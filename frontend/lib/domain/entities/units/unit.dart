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
import 'package:tensionpath/domain/json/json_unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit {
  final UnitType type;
  final int cost;
  final int maxHealth;
  final int attackRange;
  final int movementRange;
  final int visibilityRange;
  final int attack;
  final Player player;
  late int health;

  Unit({
    required this.type,
    required this.cost,
    required this.maxHealth,
    required this.attackRange,
    required this.movementRange,
    required this.visibilityRange,
    required this.attack,
    required this.player,
  }) {
    health = maxHealth;
  }

  Color get color => player.color;

  void reduceHealth(int value) {
    health -= value;
  }

  UnitComponent component({required Vector2 position, required Vector2 size});

  factory Unit.fromType({required UnitType unitType, required Player player}) {
    switch (unitType) {
      case UnitType.rifle_squad:
        return UnitRifleSquad(
          cost: unitType.cost,
          maxHealth: unitType.health,
          attackRange: unitType.attackRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          player: player,
        );
      case UnitType.sniper:
        return UnitSniper(
          cost: unitType.cost,
          maxHealth: unitType.health,
          attackRange: unitType.attackRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          player: player,
        );
      case UnitType.humvee:
        return UnitHumvee(
          cost: unitType.cost,
          maxHealth: unitType.health,
          attackRange: unitType.attackRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          player: player,
        );
      case UnitType.tank:
        return UnitTank(
          cost: unitType.cost,
          maxHealth: unitType.health,
          attackRange: unitType.attackRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          player: player,
        );
      case UnitType.artillery:
        return UnitArtillery(
          cost: unitType.cost,
          maxHealth: unitType.health,
          attackRange: unitType.attackRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          player: player,
        );
      case UnitType.helicopter:
        return UnitHelicopter(
          cost: unitType.cost,
          maxHealth: unitType.health,
          attackRange: unitType.attackRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          player: player,
        );
    }
  }

  JsonUnit toJson() => JsonUnit(
    type: type,
    cost: cost,
    maxHealth: maxHealth,
    health: health,
    attackRange: attackRange,
    movementRange: movementRange,
    visibilityRange: visibilityRange,
    attack: attack,
    player: player.id,
  );
}
