import 'package:tensionpath/domain/types/unit_class.dart';

enum UnitType {
  harvester(
    clazz: UnitClass.harvester,
    cost: 60,
    health: 500,
    speed: 2,
    visibility: 1,
    damagePlant: 0,
    damageWater: 0,
    damageFlame: 0,
    damageHarvester: 0,
    damageStructure: 0,
    attackRange: 0,
    attackCooldown: 0,
  ),
  plant_1(
    clazz: UnitClass.plant,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damagePlant: 10,
    damageWater: 20,
    damageFlame: 5,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1.5,
    attackCooldown: 1,
  ),
  plant_2(
    clazz: UnitClass.plant,
    cost: 20,
    health: 150,
    speed: 7,
    visibility: 2,
    damagePlant: 15,
    damageWater: 25,
    damageFlame: 10,
    damageHarvester: 15,
    damageStructure: 15,
    attackRange: 1.5,
    attackCooldown: 1.5,
  ),
  plant_3(
    clazz: UnitClass.plant,
    cost: 50,
    health: 200,
    speed: 5,
    visibility: 2,
    damagePlant: 20,
    damageWater: 30,
    damageFlame: 15,
    damageHarvester: 20,
    damageStructure: 20,
    attackRange: 1.5,
    attackCooldown: 2,
  ),
  water_1(
    clazz: UnitClass.water,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damagePlant: 5,
    damageWater: 10,
    damageFlame: 20,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1.5,
    attackCooldown: 1,
  ),
  water_2(
    clazz: UnitClass.water,
    cost: 20,
    health: 150,
    speed: 7,
    visibility: 2,
    damagePlant: 10,
    damageWater: 15,
    damageFlame: 25,
    damageHarvester: 15,
    damageStructure: 15,
    attackRange: 1.5,
    attackCooldown: 1.5,
  ),
  water_3(
    clazz: UnitClass.water,
    cost: 50,
    health: 200,
    speed: 5,
    visibility: 2,
    damagePlant: 15,
    damageWater: 20,
    damageFlame: 30,
    damageHarvester: 20,
    damageStructure: 20,
    attackRange: 1.5,
    attackCooldown: 2,
  ),
  flame_1(
    clazz: UnitClass.flame,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damagePlant: 20,
    damageWater: 5,
    damageFlame: 10,
    damageHarvester: 10,
    damageStructure: 10,
    attackRange: 1.5,
    attackCooldown: 1,
  ),
  flame_2(
    clazz: UnitClass.flame,
    cost: 20,
    health: 150,
    speed: 7,
    visibility: 2,
    damagePlant: 25,
    damageWater: 10,
    damageFlame: 15,
    damageHarvester: 15,
    damageStructure: 15,
    attackRange: 1.5,
    attackCooldown: 1.5,
  ),
  flame_3(
    clazz: UnitClass.flame,
    cost: 50,
    health: 200,
    speed: 5,
    visibility: 2,
    damagePlant: 30,
    damageWater: 15,
    damageFlame: 20,
    damageHarvester: 20,
    damageStructure: 20,
    attackRange: 1.5,
    attackCooldown: 2,
  );

  final UnitClass clazz;
  final int cost;
  final int health;
  final num speed;
  final int visibility;
  final num damagePlant;
  final num damageWater;
  final num damageFlame;
  final num damageHarvester;
  final num damageStructure;
  final num attackRange;
  final num attackCooldown;

  const UnitType({
    required this.clazz,
    required this.cost,
    required this.health,
    required this.speed,
    required this.visibility,
    required this.damagePlant,
    required this.damageWater,
    required this.damageFlame,
    required this.damageHarvester,
    required this.damageStructure,
    required this.attackRange,
    required this.attackCooldown,
  });

  num damageAgainst(UnitClass unitClass) {
    switch (unitClass) {
      case UnitClass.plant:
        return damagePlant;
      case UnitClass.water:
        return damageWater;
      case UnitClass.flame:
        return damageFlame;
      case UnitClass.harvester:
        return damageHarvester;
    }
  }
}
