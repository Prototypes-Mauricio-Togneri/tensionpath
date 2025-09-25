import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/types/unity_class.dart';

enum UnitType {
  harvester(
    clazz: UnitClass.harvester,
    cost: 60,
    health: 500,
    speed: 2,
    visibility: 1,
    damagePlant: 0,
    damageWater: 0,
    damageFire: 0,
    damageHarvester: 0,
    damageStructure: 0,
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
    damageFire: 5,
    damageHarvester: 10,
    damageStructure: 10,
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
    damageFire: 10,
    damageHarvester: 0,
    damageStructure: 0,
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
    damageFire: 15,
    damageHarvester: 0,
    damageStructure: 0,
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
    damageFire: 20,
    damageHarvester: 0,
    damageStructure: 0,
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
    damageFire: 25,
    damageHarvester: 0,
    damageStructure: 0,
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
    damageFire: 30,
    damageHarvester: 0,
    damageStructure: 0,
    attackCooldown: 2,
  ),
  fire_1(
    clazz: UnitClass.fire,
    cost: 10,
    health: 100,
    speed: 5,
    visibility: 3,
    damagePlant: 20,
    damageWater: 5,
    damageFire: 10,
    damageHarvester: 0,
    damageStructure: 0,
    attackCooldown: 1,
  ),
  fire_2(
    clazz: UnitClass.fire,
    cost: 20,
    health: 150,
    speed: 7,
    visibility: 2,
    damagePlant: 25,
    damageWater: 10,
    damageFire: 15,
    damageHarvester: 0,
    damageStructure: 0,
    attackCooldown: 1.5,
  ),
  fire_3(
    clazz: UnitClass.fire,
    cost: 50,
    health: 200,
    speed: 5,
    visibility: 2,
    damagePlant: 30,
    damageWater: 15,
    damageFire: 20,
    damageHarvester: 0,
    damageStructure: 0,
    attackCooldown: 2,
  );

  final UnitClass clazz;
  final int cost;
  final int health;
  final num speed;
  final int visibility;
  final num damagePlant;
  final num damageWater;
  final num damageFire;
  final num damageHarvester;
  final num damageStructure;
  final num attackCooldown;

  const UnitType({
    required this.clazz,
    required this.cost,
    required this.health,
    required this.speed,
    required this.visibility,
    required this.damagePlant,
    required this.damageWater,
    required this.damageFire,
    required this.damageHarvester,
    required this.damageStructure,
    required this.attackCooldown,
  });

  num damageAgainst(Unit unit) {
    switch (unit.type.clazz) {
      case UnitClass.plant:
        return damagePlant;
      case UnitClass.water:
        return damageWater;
      case UnitClass.fire:
        return damageFire;
      case UnitClass.harvester:
        return damageHarvester;
    }
  }
}
