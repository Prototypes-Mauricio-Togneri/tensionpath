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
  late int _health;
  late int _moves;
  final Player player;

  Unit({
    required this.type,
    required int health,
    required int moves,
    required this.player,
  }) {
    _health = health;
    _moves = moves;
  }

  Color get color => player.color;

  int get deploymentCost => type.deploymentCost;

  int get movementCost => type.movementCost;

  int get health => _health;

  int get maxHealth => type.maxHealth;

  int get visibilityRange => type.visibilityRange;

  int get movementRange => type.movementRange;

  int get maxMoves => type.movementRange - _moves;

  int get attackRange => type.attackRange;

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
          health: unitType.maxHealth,
          moves: 0,
          player: player,
        );
      case UnitType.sniper:
        return UnitSniper(health: unitType.maxHealth, moves: 0, player: player);
      case UnitType.humvee:
        return UnitHumvee(health: unitType.maxHealth, moves: 0, player: player);
      case UnitType.tank:
        return UnitTank(health: unitType.maxHealth, moves: 0, player: player);
      case UnitType.artillery:
        return UnitArtillery(
          health: unitType.maxHealth,
          moves: 0,
          player: player,
        );
      case UnitType.helicopter:
        return UnitHelicopter(
          health: unitType.maxHealth,
          moves: 0,
          player: player,
        );
    }
  }

  JsonUnit toJson() => JsonUnit(
    type: type,
    deploymentCost: deploymentCost,
    movementCost: movementCost,
    health: _health,
    maxHealth: maxHealth,
    movementRange: movementRange,
    visibilityRange: visibilityRange,
    attackRange: attackRange,
    moves: _moves,
    player: player.id,
  );
}
