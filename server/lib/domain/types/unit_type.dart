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
    damageInfantry: 110,
    damageVehicle: 44,
    damageAircraft: 0,
    damageHarvester: 44,
    damageStructure: 110,
    attackRange: 1,
    attackCooldown: 1.72,
  ),
  shocks(
    clazz: UnitClass.infantry,
    cost: 40,
    health: 1200,
    speed: 4.42,
    visibility: 2,
    damageInfantry: 225,
    damageVehicle: 45,
    damageAircraft: 0,
    damageHarvester: 45,
    damageStructure: 300,
    attackRange: 1,
    attackCooldown: 0.66,
  ),
  missiles(
    clazz: UnitClass.infantry,
    cost: 20,
    health: 880,
    speed: 3.53,
    visibility: 2,
    damageInfantry: 28,
    damageVehicle: 200,
    damageAircraft: 200,
    damageHarvester: 200,
    damageStructure: 200,
    attackRange: 1,
    attackCooldown: 1.25,
  ),
  grenadier(
    clazz: UnitClass.infantry,
    cost: 70,
    health: 1860,
    speed: 4.42,
    visibility: 2,
    damageInfantry: 31,
    damageVehicle: 386,
    damageAircraft: 0,
    damageHarvester: 386,
    damageStructure: 386,
    attackRange: 1,
    attackCooldown: 0.88,
  ),
  sniper(
    clazz: UnitClass.infantry,
    cost: 50,
    health: 750,
    speed: 4.42,
    visibility: 2,
    damageInfantry: 169,
    damageVehicle: 22,
    damageAircraft: 0,
    damageHarvester: 22,
    damageStructure: 22,
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
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 2,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  predator(
    clazz: UnitClass.vehicle,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 2,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  mlrs(
    clazz: UnitClass.vehicle,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 2,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),

  // =============================== AIRCRAFT =============================== \\

  talon(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 2,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  razorback(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 2,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  orca(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 2,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  mohawk(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 2,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  hammerhead(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 2,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1,
    attackCooldown: 1,
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
}
