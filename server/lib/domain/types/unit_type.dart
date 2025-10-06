import 'dart:math';
import 'package:tensionpath/domain/types/unit_class.dart';

enum UnitType {
  // ============================== HARVESTER =============================== \\
  harvester(
    clazz: UnitClass.harvester,
    cost: 60,
    health: 3400,
    speed: 2.52,
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
    cost: 10,
    health: 650,
    speed: 4.42,
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
    cost: 40,
    health: 1200,
    speed: 4.42,
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
    cost: 20,
    health: 880,
    speed: 3.53,
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
    cost: 70,
    health: 1860,
    speed: 4.42,
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
    cost: 50,
    health: 750,
    speed: 4.42,
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
    cost: 30,
    health: 1611,
    speed: 4.42,
    visibility: 3,
    damageInfantry: 107,
    damageVehicle: 80,
    damageAircraft: 109,
    damageHarvester: 80,
    damageStructure: 107,
    attackRange: 1,
    attackCooldown: 0.75,
  ),
  pitbull(
    clazz: UnitClass.vehicle,
    cost: 40,
    health: 1611,
    speed: 4.42,
    visibility: 2,
    damageInfantry: 33,
    damageVehicle: 139,
    damageAircraft: 250,
    damageHarvester: 139,
    damageStructure: 139,
    attackRange: 1,
    attackCooldown: 1.8,
  ),
  shatterer(
    clazz: UnitClass.vehicle,
    cost: 50,
    health: 1790,
    speed: 4.42,
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
    cost: 70,
    health: 2823,
    speed: 2.52,
    visibility: 2,
    damageInfantry: 28,
    damageVehicle: 241,
    damageAircraft: 0,
    damageHarvester: 241,
    damageStructure: 241,
    attackRange: 1,
    attackCooldown: 3.44,
  ),
  mlrs(
    clazz: UnitClass.vehicle,
    cost: 70,
    health: 1500,
    speed: 3.53,
    visibility: 2,
    damageInfantry: 24,
    damageVehicle: 400,
    damageAircraft: 0,
    damageHarvester: 400,
    damageStructure: 600,
    attackRange: 2,
    attackCooldown: 5,
  ),

  // =============================== AIRCRAFT =============================== \\

  talon(
    clazz: UnitClass.aircraft,
    cost: 30,
    health: 909,
    speed: 5.1,
    visibility: 2,
    damageInfantry: 114,
    damageVehicle: 40,
    damageAircraft: 173,
    damageHarvester: 40,
    damageStructure: 173,
    attackRange: 1,
    attackCooldown: 2,
  ),
  razorback(
    clazz: UnitClass.aircraft,
    cost: 60,
    health: 1530,
    speed: 4.42,
    visibility: 2,
    damageInfantry: 175,
    damageVehicle: 43,
    damageAircraft: 0,
    damageHarvester: 43,
    damageStructure: 70,
    attackRange: 1,
    attackCooldown: 0.4,
  ),
  orca(
    clazz: UnitClass.aircraft,
    cost: 70,
    health: 1210,
    speed: 5.1,
    visibility: 2,
    damageInfantry: 33,
    damageVehicle: 227,
    damageAircraft: 0,
    damageHarvester: 227,
    damageStructure: 227,
    attackRange: 1,
    attackCooldown: 9,
  ),
  mohawk(
    clazz: UnitClass.aircraft,
    cost: 50,
    health: 1650,
    speed: 4.42,
    visibility: 2,
    damageInfantry: 48,
    damageVehicle: 332,
    damageAircraft: 0,
    damageHarvester: 257,
    damageStructure: 332,
    attackRange: 1,
    attackCooldown: 1.3,
  ),
  hammerhead(
    clazz: UnitClass.aircraft,
    cost: 90,
    health: 1950,
    speed: 5.89,
    visibility: 2,
    damageInfantry: 0,
    damageVehicle: 0,
    damageAircraft: 366,
    damageHarvester: 0,
    damageStructure: 266,
    attackRange: 1,
    attackCooldown: 1.6,
  );

  final UnitClass clazz;
  final int cost;
  final int health;
  final num speed; // Speed / 1.567
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

  int counterAgainst(UnitClass unitClass) {
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

  int _relativeDamage(double damage, double maxDamage) {
    if (damage == 0) {
      return -1;
    } else if (damage == maxDamage) {
      return 1;
    } else {
      return 0;
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
