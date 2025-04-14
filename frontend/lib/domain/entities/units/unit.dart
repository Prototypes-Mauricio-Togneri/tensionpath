import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit_artillery.dart';
import 'package:tensionpath/domain/entities/units/unit_fuel_truck.dart';
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

  int get remainingMoves => type.movementRange - _moves;

  int get attackRange => type.attackRange;

  void reduceHealth(int value) {
    _health -= value;
  }

  void increaseMoves(int value) {
    _moves += value;
  }

  void reset() {
    _moves = 0;
  }

  bool belongsTo(Player player) => this.player.id == player.id;

  UnitComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  });

  factory Unit.create({
    required UnitType unitType,
    required int health,
    required int moves,
    required Player player,
  }) {
    switch (unitType) {
      case UnitType.fuel_truck:
        return UnitFuelTruck(health: health, moves: moves, player: player);
      case UnitType.rifle_squad:
        return UnitRifleSquad(health: health, moves: moves, player: player);
      case UnitType.sniper:
        return UnitSniper(health: health, moves: moves, player: player);
      case UnitType.humvee:
        return UnitHumvee(health: health, moves: moves, player: player);
      case UnitType.tank:
        return UnitTank(health: health, moves: moves, player: player);
      case UnitType.artillery:
        return UnitArtillery(health: health, moves: moves, player: player);
      case UnitType.helicopter:
        return UnitHelicopter(health: health, moves: moves, player: player);
    }
  }

  JsonUnit toJson() =>
      JsonUnit(type: type, health: _health, moves: _moves, player: player.id);
}
