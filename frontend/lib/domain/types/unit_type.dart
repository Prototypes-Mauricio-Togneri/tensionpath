import 'dart:math';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_speed.dart';

enum UnitType {
  // ============================== HARVESTER =============================== \\
  harvester(
    clazz: UnitClass.harvester,
    buildingType: BuildingType.main,
    cost: 60,
    health: 3400,
    speed: UnitSpeed.slow,
    visibility: 1,
    damageInfantry: 0,
    damageVehicle: 0,
    damageAircraft: 0,
    damageHarvester: 0,
    damageStructure: 0,
    attackRange: 0,
    attackCooldown: 0,
  ),

  // =============================== INFANTRY =============================== \\
  riflemen(
    clazz: UnitClass.infantry,
    buildingType: BuildingType.barracks,
    cost: 10,
    health: 650,
    speed: UnitSpeed.fast,
    visibility: 3,
    damageInfantry: 38,
    damageVehicle: 15,
    damageAircraft: 0,
    damageHarvester: 38,
    damageStructure: 38,
    attackRange: 1,
    attackCooldown: 0.344,
  ),
  shocks(
    clazz: UnitClass.infantry,
    buildingType: BuildingType.barracks,
    cost: 40,
    health: 1200,
    speed: UnitSpeed.fast,
    visibility: 2,
    damageInfantry: 150,
    damageVehicle: 30,
    damageAircraft: 0,
    damageHarvester: 30,
    damageStructure: 200,
    attackRange: 1,
    attackCooldown: 0.66,
  ),
  missiles(
    clazz: UnitClass.infantry,
    buildingType: BuildingType.barracks,
    cost: 20,
    health: 880,
    speed: UnitSpeed.normal,
    visibility: 2,
    damageInfantry: 35,
    damageVehicle: 250,
    damageAircraft: 250,
    damageHarvester: 250,
    damageStructure: 250,
    attackRange: 1,
    attackCooldown: 1.25,
  ),
  grenadier(
    clazz: UnitClass.infantry,
    buildingType: BuildingType.barracks,
    cost: 70,
    health: 1860,
    speed: UnitSpeed.fast,
    visibility: 2,
    damageInfantry: 27,
    damageVehicle: 340,
    damageAircraft: 0,
    damageHarvester: 340,
    damageStructure: 340,
    attackRange: 1,
    attackCooldown: 0.88,
  ),
  sniper(
    clazz: UnitClass.infantry,
    buildingType: BuildingType.barracks,
    cost: 50,
    health: 750,
    speed: UnitSpeed.fast,
    visibility: 2,
    damageInfantry: 152,
    damageVehicle: 20,
    damageAircraft: 0,
    damageHarvester: 20,
    damageStructure: 20,
    attackRange: 2,
    attackCooldown: 0.9,
  ),

  // =============================== VEHICLE ================================ \\
  rhino(
    clazz: UnitClass.vehicle,
    buildingType: BuildingType.factory,
    cost: 30,
    health: 1611,
    speed: UnitSpeed.fast,
    visibility: 3,
    damageInfantry: 80,
    damageVehicle: 60,
    damageAircraft: 80,
    damageHarvester: 60,
    damageStructure: 80,
    attackRange: 1,
    attackCooldown: 0.75,
  ),
  pitbull(
    clazz: UnitClass.vehicle,
    buildingType: BuildingType.factory,
    cost: 40,
    health: 1611,
    speed: UnitSpeed.fast,
    visibility: 2,
    damageInfantry: 35,
    damageVehicle: 250,
    damageAircraft: 250,
    damageHarvester: 250,
    damageStructure: 250,
    attackRange: 1,
    attackCooldown: 1.8,
  ),
  shatterer(
    clazz: UnitClass.vehicle,
    buildingType: BuildingType.factory,
    cost: 50,
    health: 1790,
    speed: UnitSpeed.fast,
    visibility: 2,
    damageInfantry: 210,
    damageVehicle: 45,
    damageAircraft: 0,
    damageHarvester: 45,
    damageStructure: 210,
    attackRange: 1,
    attackCooldown: 0.7,
  ),
  predator(
    clazz: UnitClass.vehicle,
    buildingType: BuildingType.factory,
    cost: 70,
    health: 2823,
    speed: UnitSpeed.slow,
    visibility: 2,
    damageInfantry: 96,
    damageVehicle: 830,
    damageAircraft: 0,
    damageHarvester: 830,
    damageStructure: 830,
    attackRange: 1,
    attackCooldown: 3.44,
  ),
  mlrs(
    clazz: UnitClass.vehicle,
    buildingType: BuildingType.factory,
    cost: 70,
    health: 1500,
    speed: UnitSpeed.normal,
    visibility: 2,
    damageInfantry: 120,
    damageVehicle: 1998,
    damageAircraft: 0,
    damageHarvester: 1998,
    damageStructure: 3000,
    attackRange: 2,
    attackCooldown: 5,
  ),

  // =============================== AIRCRAFT =============================== \\

  talon(
    clazz: UnitClass.aircraft,
    buildingType: BuildingType.airfield,
    cost: 30,
    health: 909,
    speed: UnitSpeed.fastest,
    visibility: 2,
    damageInfantry: 57,
    damageVehicle: 20,
    damageAircraft: 345,
    damageHarvester: 20,
    damageStructure: 345,
    attackRange: 1,
    attackCooldown: 2,
  ),
  razorback(
    clazz: UnitClass.aircraft,
    buildingType: BuildingType.airfield,
    cost: 60,
    health: 1530,
    speed: UnitSpeed.fast,
    visibility: 2,
    damageInfantry: 70,
    damageVehicle: 17,
    damageAircraft: 0,
    damageHarvester: 17,
    damageStructure: 28,
    attackRange: 1,
    attackCooldown: 0.4,
  ),
  orca(
    clazz: UnitClass.aircraft,
    buildingType: BuildingType.airfield,
    cost: 70,
    health: 1210,
    speed: UnitSpeed.fastest,
    visibility: 2,
    damageInfantry: 300,
    damageVehicle: 2040,
    damageAircraft: 0,
    damageHarvester: 2040,
    damageStructure: 2040,
    attackRange: 1,
    attackCooldown: 9,
  ),
  mohawk(
    clazz: UnitClass.aircraft,
    buildingType: BuildingType.airfield,
    cost: 50,
    health: 1650,
    speed: UnitSpeed.fast,
    visibility: 2,
    damageInfantry: 55,
    damageVehicle: 382,
    damageAircraft: 0,
    damageHarvester: 295,
    damageStructure: 382,
    attackRange: 1,
    attackCooldown: 1.3,
  ),
  hammerhead(
    clazz: UnitClass.aircraft,
    buildingType: BuildingType.airfield,
    cost: 90,
    health: 1950,
    speed: UnitSpeed.fastest,
    visibility: 2,
    damageInfantry: 0,
    damageVehicle: 0,
    damageAircraft: 585,
    damageHarvester: 0,
    damageStructure: 425,
    attackRange: 1,
    attackCooldown: 1.6,
  )
  ;

  final UnitClass clazz;
  final BuildingType buildingType;
  final int cost;
  final int health;
  final UnitSpeed speed; // Speed / 1.567
  final int visibility;
  final num damageInfantry;
  final num damageVehicle;
  final num damageAircraft;
  final num damageHarvester;
  final num damageStructure;
  final num attackRange;
  final num attackCooldown; // Cooldown / squad size

  const UnitType({
    required this.clazz,
    required this.buildingType,
    required this.cost,
    required this.health,
    required this.speed,
    required this.visibility,
    required this.damageInfantry,
    required this.damageVehicle,
    required this.damageAircraft,
    required this.damageHarvester,
    required this.damageStructure,
    required this.attackRange,
    required this.attackCooldown,
  });

  num damageAgainst(UnitClass unitClass) {
    switch (unitClass) {
      case UnitClass.structure:
        return damageStructure;
      case UnitClass.harvester:
        return damageHarvester;
      case UnitClass.infantry:
        return damageInfantry;
      case UnitClass.vehicle:
        return damageVehicle;
      case UnitClass.aircraft:
        return damageAircraft;
    }
  }

  String counterAgainst(UnitClass unitClass) {
    final double maxDamage = max(
      max(damageInfantry.toDouble(), damageVehicle.toDouble()),
      damageAircraft.toDouble(),
    );

    switch (unitClass) {
      case UnitClass.infantry:
        return _relativeDamage(damageInfantry.toDouble(), maxDamage);
      case UnitClass.vehicle:
        return _relativeDamage(damageVehicle.toDouble(), maxDamage);
      case UnitClass.aircraft:
        return _relativeDamage(damageAircraft.toDouble(), maxDamage);
      default:
        throw Exception('Invalid unit class');
    }
  }

  String _relativeDamage(double damage, double maxDamage) {
    if (damage == 0) {
      return 'bad';
    } else if (damage == maxDamage) {
      return 'good';
    } else {
      return 'normal';
    }
  }

  String get stats {
    String result = name.toUpperCase();

    result += '\nCost: $cost';
    result += '\nHealth: $health';
    result += '\nSpeed: $speed';
    result += '\nVisibility: $visibility';
    result += '\nDamage infantry: $damageInfantry';
    result += '\nDamage vehicle: $damageVehicle';
    result += '\nDamage aircraft: $damageAircraft';
    result += '\nDamage harvester: $damageHarvester';
    result += '\nDamage structure: $damageStructure';
    result += '\nAttack range: $attackRange';
    result += '\nAttack cooldown: $attackCooldown';

    return result;
  }
}
