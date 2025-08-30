import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/localizable.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit_aircraft.dart';
import 'package:tensionpath/domain/entities/units/unit_harvester.dart';
import 'package:tensionpath/domain/entities/units/unit_infantry.dart';
import 'package:tensionpath/domain/entities/units/unit_tank.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

abstract class Unit implements Localizable {
  final UnitType type;
  final JsonPlayer player;
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

  int get minAttackRange => type.minAttackRange;

  int get maxAttackRange => type.maxAttackRange;

  bool belongsTo(JsonPlayer player) => this.player.id == player.id;

  String get sprite => 'units/player_${player.id}/${type.spriteName}.png';

  int distance(Localizable localizable) => _location.distance(localizable);

  bool isInRange(Unit unit) {
    final int unitDistance = distance(unit);

    return unitDistance >= minAttackRange && unitDistance <= maxAttackRange;
  }

  int damageTo(Unit unit) {
    if (unit.type == UnitType.harvester) {
      return type.damageHarvester;
    } else {
      final UnitClass defenderClass = unit.type.unitClass;

      switch (defenderClass) {
        case UnitClass.infantry:
          return type.damageInfantry;
        case UnitClass.vehicle:
          return type.damageVehicle;
        case UnitClass.aircraft:
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
    required JsonPlayer player,
    required int health,
    required int remainingMoves,
    required int remainingAttacks,
  }) {
    switch (unitType) {
      case UnitType.harvester:
        return UnitHarvester(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.infrantry:
        return UnitInfantry(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.vehicle:
        return UnitVehicle(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
      case UnitType.aircraft:
        return UnitAircraft(
          location: location,
          player: player,
          health: health,
          remainingMoves: remainingMoves,
          remainingAttacks: remainingAttacks,
        );
    }
  }
}
