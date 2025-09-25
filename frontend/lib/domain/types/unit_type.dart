import 'dart:math';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/utils/assets.dart';

enum UnitType {
  harvester(
    unitClass: UnitClass.neutral,
    deploymentCost: 60,
    maxHealth: 1000,
    speed: 3,
    visibilityRange: 1,
    sprite: Assets.IMAGES_UNITS_HARVESTER,
    spriteScale: 0.5,
  ),
  plant_1(
    unitClass: UnitClass.plant,
    deploymentCost: 10,
    maxHealth: 300,
    speed: 5,
    visibilityRange: 3,
    damageInfantry: 80,
    damageVehicle: 60,
    damageAir: 0,
    damageHarvester: 50,
    damageStructure: 50,
    sprite: Assets.IMAGES_UNITS_PLANT_1,
    spriteScale: 0.5,
  ),
  plant_2(
    unitClass: UnitClass.plant,
    deploymentCost: 20,
    maxHealth: 300,
    speed: 4,
    visibilityRange: 2,
    damageInfantry: 40,
    damageVehicle: 150,
    damageAir: 150,
    damageHarvester: 100,
    damageStructure: 80,
    sprite: Assets.IMAGES_UNITS_PLANT_2,
    spriteScale: 0.6,
  ),
  plant_3(
    unitClass: UnitClass.plant,
    deploymentCost: 50,
    maxHealth: 150,
    speed: 6,
    visibilityRange: 3,
    damageInfantry: 100,
    damageVehicle: 40,
    damageAir: 0,
    damageHarvester: 40,
    damageStructure: 40,
    sprite: Assets.IMAGES_UNITS_PLANT_3,
    spriteScale: 0.5,
  ),
  water_1(
    unitClass: UnitClass.water,
    deploymentCost: 50,
    maxHealth: 150,
    speed: 6,
    visibilityRange: 3,
    damageInfantry: 100,
    damageVehicle: 40,
    damageAir: 0,
    damageHarvester: 40,
    damageStructure: 40,
    sprite: Assets.IMAGES_UNITS_WATER_1,
    spriteScale: 0.5,
  ),
  water_2(
    unitClass: UnitClass.water,
    deploymentCost: 50,
    maxHealth: 150,
    speed: 6,
    visibilityRange: 3,
    damageInfantry: 100,
    damageVehicle: 40,
    damageAir: 0,
    damageHarvester: 40,
    damageStructure: 40,
    sprite: Assets.IMAGES_UNITS_WATER_2,
    spriteScale: 0.5,
  ),
  water_3(
    unitClass: UnitClass.water,
    deploymentCost: 50,
    maxHealth: 150,
    speed: 6,
    visibilityRange: 3,
    damageInfantry: 100,
    damageVehicle: 40,
    damageAir: 0,
    damageHarvester: 40,
    damageStructure: 40,
    sprite: Assets.IMAGES_UNITS_WATER_3,
    spriteScale: 0.5,
  ),
  fire_1(
    unitClass: UnitClass.fire,
    deploymentCost: 50,
    maxHealth: 150,
    speed: 6,
    visibilityRange: 3,
    damageInfantry: 100,
    damageVehicle: 40,
    damageAir: 0,
    damageHarvester: 40,
    damageStructure: 40,
    sprite: Assets.IMAGES_UNITS_FIRE_1,
    spriteScale: 0.5,
  ),
  fire_2(
    unitClass: UnitClass.fire,
    deploymentCost: 50,
    maxHealth: 150,
    speed: 6,
    visibilityRange: 3,
    damageInfantry: 100,
    damageVehicle: 40,
    damageAir: 0,
    damageHarvester: 40,
    damageStructure: 40,
    sprite: Assets.IMAGES_UNITS_FIRE_2,
    spriteScale: 0.5,
  ),
  fire_3(
    unitClass: UnitClass.fire,
    deploymentCost: 50,
    maxHealth: 150,
    speed: 6,
    visibilityRange: 3,
    damageInfantry: 100,
    damageVehicle: 40,
    damageAir: 0,
    damageHarvester: 40,
    damageStructure: 40,
    sprite: Assets.IMAGES_UNITS_FIRE_3,
    spriteScale: 0.5,
  );

  final UnitClass unitClass;
  final int deploymentCost;
  final int maxHealth;
  final num speed;
  final int visibilityRange;
  final int damageInfantry;
  final int damageVehicle;
  final int damageAir;
  final int damageHarvester;
  final int damageStructure;
  final String sprite;
  final double spriteScale;

  const UnitType({
    required this.unitClass,
    required this.deploymentCost,
    required this.maxHealth,
    required this.speed,
    required this.visibilityRange,
    required this.damageInfantry,
    required this.damageVehicle,
    required this.damageAir,
    required this.damageHarvester,
    required this.damageStructure,
    required this.sprite,
    required this.spriteScale,
  });

  int damageAgainst(UnitClass unitClass) {
    final int maxDamage = max(max(damageInfantry, damageVehicle), damageAir);

    switch (unitClass) {
      case UnitClass.plant:
        return _relativeDamage(damageInfantry, maxDamage);
      case UnitClass.water:
        return _relativeDamage(damageVehicle, maxDamage);
      case UnitClass.fire:
        return _relativeDamage(damageAir, maxDamage);
      case UnitClass.neutral:
        return _relativeDamage(damageHarvester, maxDamage);
    }
  }

  int _relativeDamage(int damage, int maxDamage) {
    if (damage == 0) {
      return -1;
    } else if (damage == maxDamage) {
      return 1;
    } else {
      return 0;
    }
  }
}
