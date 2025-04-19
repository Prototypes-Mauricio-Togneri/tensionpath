import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit_artillery.dart';
import 'package:tensionpath/domain/entities/units/unit_fuel_truck.dart';
import 'package:tensionpath/domain/entities/units/unit_helicopter.dart';
import 'package:tensionpath/domain/entities/units/unit_humvee.dart';
import 'package:tensionpath/domain/entities/units/unit_rifle_squad.dart';
import 'package:tensionpath/domain/entities/units/unit_rocket_vehicle.dart';
import 'package:tensionpath/domain/entities/units/unit_rpg_team.dart';
import 'package:tensionpath/domain/entities/units/unit_sniper.dart';
import 'package:tensionpath/domain/entities/units/unit_tank.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit {
  final UnitType type;
  final Location location;
  final Player player;
  late int _health;
  late int _moves;

  Unit({
    required this.type,
    required this.location,
    required this.player,
    required int health,
    required int moves,
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

  int get moves => _moves;

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
    required Node node,
    required Player player,
    required int health,
    required int moves,
  }) {
    switch (unitType) {
      case UnitType.fuel_truck:
        return UnitFuelTruck(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
      case UnitType.rifle_squad:
        return UnitRifleSquad(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
      case UnitType.rpg_team:
        return UnitRpgTeam(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
      case UnitType.sniper:
        return UnitSniper(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
      case UnitType.humvee:
        return UnitHumvee(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
      case UnitType.rocket_vehicle:
        return UnitRocketVehicle(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
      case UnitType.tank:
        return UnitTank(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
      case UnitType.artillery:
        return UnitArtillery(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
      case UnitType.helicopter:
        return UnitHelicopter(
          location: node.location,
          player: player,
          health: health,
          moves: moves,
        );
    }
  }
}
