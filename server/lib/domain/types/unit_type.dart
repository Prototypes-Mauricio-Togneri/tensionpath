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
    damageStructure: 0,
    damageHarvester: 0,
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
    damageInfantry: 190,
    damageVehicle: 75,
    damageAircraft: 0,
    damageStructure: 190,
    damageHarvester: 75,
    attackRange: 1,
    attackCooldown: 1.72,
  ),
  shocks(
    clazz: UnitClass.infantry,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  missiles(
    clazz: UnitClass.infantry,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  grenadier(
    clazz: UnitClass.infantry,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  sniper(
    clazz: UnitClass.infantry,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),

  // =============================== VEHICLE ================================ \\
  rhino(
    clazz: UnitClass.vehicle,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  pitbull(
    clazz: UnitClass.vehicle,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  shatterer(
    clazz: UnitClass.vehicle,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  predator(
    clazz: UnitClass.vehicle,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  mlrs(
    clazz: UnitClass.vehicle,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),

  // =============================== AIRCRAFT =============================== \\

  talon(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  razorback(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  orca(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  mohawk(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  ),
  hammerhead(
    clazz: UnitClass.aircraft,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damageInfantry: 10,
    damageVehicle: 20,
    damageAircraft: 5,
    damageStructure: 10,
    damageHarvester: 10,
    attackRange: 1,
    attackCooldown: 1,
  );

  final UnitClass clazz;
  final int cost;
  final int health;
  final num speed; // Rivals value / 1.567
  final int visibility;
  final num damageInfantry;
  final num damageVehicle;
  final num damageAircraft;
  final num damageStructure;
  final num damageHarvester;
  final num attackRange;
  final num attackCooldown;

  const UnitType({
    required this.clazz,
    required this.cost,
    required this.health,
    required this.speed,
    required this.visibility,
    required this.damageInfantry,
    required this.damageVehicle,
    required this.damageAircraft,
    required this.damageStructure,
    required this.damageHarvester,
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
