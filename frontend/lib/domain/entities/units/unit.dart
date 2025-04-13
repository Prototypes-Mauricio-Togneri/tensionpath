import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
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
  final int shootingRange;
  final int movementRange;
  final int visibilityRange;
  final int attack;
  final Player player;
  late int _health;
  late int _moves;

  Unit({
    required this.type,
    required this.cost,
    required int health,
    required this.maxHealth,
    required this.shootingRange,
    required this.movementRange,
    required this.visibilityRange,
    required this.attack,
    required int moves,
    required this.player,
  }) {
    _health = health;
    _moves = moves;
  }

  int get health => _health;

  Color get color => player.color;

  int get maxMoves => movementRange - _moves;

  void reduceHealth(int value) {
    _health -= value;
  }

  void increaseMoves(int value) {
    _moves += value;
  }

  bool belongsTo(Player player) => this.player.id == player.id;

  UnitComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  });

  factory Unit.fromType({required UnitType unitType, required Player player}) {
    switch (unitType) {
      case UnitType.rifle_squad:
        return UnitRifleSquad(
          cost: unitType.cost,
          health: unitType.health,
          maxHealth: unitType.health,
          shootingRange: unitType.shootingRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          moves: 0,
          player: player,
        );
      case UnitType.sniper:
        return UnitSniper(
          cost: unitType.cost,
          health: unitType.health,
          maxHealth: unitType.health,
          shootingRange: unitType.shootingRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          moves: 0,
          player: player,
        );
      case UnitType.humvee:
        return UnitHumvee(
          cost: unitType.cost,
          health: unitType.health,
          maxHealth: unitType.health,
          shootingRange: unitType.shootingRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          moves: 0,
          player: player,
        );
      case UnitType.tank:
        return UnitTank(
          cost: unitType.cost,
          health: unitType.health,
          maxHealth: unitType.health,
          shootingRange: unitType.shootingRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          moves: 0,
          player: player,
        );
      case UnitType.artillery:
        return UnitArtillery(
          cost: unitType.cost,
          health: unitType.health,
          maxHealth: unitType.health,
          shootingRange: unitType.shootingRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          moves: 0,
          player: player,
        );
      case UnitType.helicopter:
        return UnitHelicopter(
          cost: unitType.cost,
          health: unitType.health,
          maxHealth: unitType.health,
          shootingRange: unitType.shootingRange,
          movementRange: unitType.movementRange,
          visibilityRange: unitType.visibilityRange,
          attack: unitType.attack,
          moves: 0,
          player: player,
        );
    }
  }

  JsonUnit toJson() => JsonUnit(
    type: type,
    cost: cost,
    maxHealth: maxHealth,
    health: _health,
    shootingRange: shootingRange,
    movementRange: movementRange,
    visibilityRange: visibilityRange,
    attack: attack,
    moves: _moves,
    player: player.id,
  );
}
