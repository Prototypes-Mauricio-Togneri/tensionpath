import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/localizable.dart';
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
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit implements Localizable {
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

  @override
  Location get getLocation => _location;

  int get health => _health;

  bool get isAlive => _health > 0;

  int get remainingMoves => _remainingMoves;

  int get remainingAttacks => _remainingAttacks;

  int get deploymentCost => type.deploymentCost;

  int get movementCost => type.movementCost;

  int get maxHealth => type.maxHealth;

  int get visibilityRange => type.visibilityRange;

  int get movementRange => type.movementRange;

  int get attackRange => type.attackRange;

  bool belongsTo(Player player) => this.player.id == player.id;

  String get sprite => 'units/player_${player.id}/${type.sprite}.png';

  List<Unit?> battle({required Unit attacker, required Unit defender}) {
    final int attackerDamage = attacker.damageTo(defender);
    final int defenderDamage = defender.damageTo(attacker);

    final Unit attackerResult = attacker
        .withDamage(defenderDamage)
        .withRemainingAttacks(attacker.remainingAttacks - 1);
    final Unit defenderResult = defender.withDamage(attackerDamage);

    return [
      if (attackerResult.isAlive) attackerResult else null,
      if (defenderResult.isAlive) defenderResult else null,
    ];
  }

  int damageTo(Unit unit) {
    if (unit.type == UnitType.fuel_truck) {
      return type.damageFuelTruck;
    } else {
      final UnitClass defenderClass = unit.type.unitClass;

      switch (defenderClass) {
        case UnitClass.infantry:
          return type.damageInfantry;
        case UnitClass.vehicle:
          return type.damageVehicle;
        case UnitClass.air:
          return type.damageAir;
      }
    }
  }

  Unit withDamage(int damage) => Unit.create(
    unitType: type,
    location: _location,
    player: player,
    health: (_health - damage).clamp(0, maxHealth),
    remainingMoves: _remainingMoves,
    remainingAttacks: _remainingAttacks,
  );

  Unit withRemainingAttacks(int value) => Unit.create(
    unitType: type,
    location: _location,
    player: player,
    health: _health,
    remainingMoves: _remainingMoves,
    remainingAttacks: value,
  );

  void replaceWith({required Unit newUnit, required Location location}) {
    _location = location;
    _health = newUnit._health;
    _remainingMoves = newUnit._remainingMoves;
    _remainingAttacks = newUnit._remainingAttacks;
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
