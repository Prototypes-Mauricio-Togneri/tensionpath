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
  final Player player;
  late Location _location;
  late int _health;
  late int _remainingMoves;
  late int _remainingAttacks;

  Unit({
    required this.type,
    required this.player,
    required Location location,
    required int health,
    required int remainingMoves,
    required int remainingAttacks,
  }) {
    _location = location;
    _health = health;
    _remainingMoves = remainingMoves;
    _remainingAttacks = remainingAttacks;
  }

  Location get location => _location;

  int get health => _health;

  int get remainingMoves => _remainingMoves;

  int get remainingAttacks => _remainingAttacks;

  int get deploymentCost => type.deploymentCost;

  int get movementCost => type.movementCost;

  int get maxHealth => type.maxHealth;

  int get visibilityRange => type.visibilityRange;

  int get movementRange => type.movementRange;

  int get attackRange => type.attackRange;

  bool belongsTo(Player player) => this.player.id == player.id;

  void replaceWith({required Unit unit, required Location location}) {
    _location = location;
    _health = unit._health;
    _remainingMoves = unit._remainingMoves;
    _remainingAttacks = unit._remainingAttacks;
  }

  UnitComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  });

  factory Unit.create({
    required UnitType unitType,
    required Location location,
    required Player player,
    required int health,
    required int remainingMoves,
    required int remainingAttacks,
  }) {
    switch (unitType) {
      case UnitType.fuel_truck:
        return UnitFuelTruck(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.rifle_squad:
        return UnitRifleSquad(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.rpg_team:
        return UnitRpgTeam(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.sniper:
        return UnitSniper(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.humvee:
        return UnitHumvee(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.rocket_vehicle:
        return UnitRocketVehicle(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.tank:
        return UnitTank(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.artillery:
        return UnitArtillery(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.helicopter:
        return UnitHelicopter(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
    }
  }
}
