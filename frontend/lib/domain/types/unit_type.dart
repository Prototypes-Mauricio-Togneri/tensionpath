import 'dart:math';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/utils/assets.dart';

enum UnitType {
  harvester(
    unitClass: UnitClass.vehicle,
    deploymentCost: 60,
    movementCost: 1,
    maxHealth: 1000,
    movementRange: 1,
    visibilityRange: 1,
    minAttackRange: 0,
    maxAttackRange: 0,
    numberOfAttacks: 0,
    damageInfantry: 0,
    damageVehicle: 0,
    damageAir: 0,
    damageHarvester: 0,
    damageStructure: 0,
    sprite: Assets.IMAGES_UNITS_HARVESTER,
    spriteScale: 0.8,
    thumbnail: Assets.IMAGES_UNITS_HARVESTER,
  ),
  infrantry(
    unitClass: UnitClass.infantry,
    deploymentCost: 10,
    movementCost: 1,
    maxHealth: 300,
    movementRange: 1,
    visibilityRange: 3,
    minAttackRange: 1,
    maxAttackRange: 1,
    numberOfAttacks: 1,
    damageInfantry: 80,
    damageVehicle: 60,
    damageAir: 0,
    damageHarvester: 50,
    damageStructure: 50,
    sprite: Assets.IMAGES_UNITS_INFANTRY,
    spriteScale: 0.5,
    thumbnail: Assets.IMAGES_UNITS_INFANTRY,
  ),
  vehicle(
    unitClass: UnitClass.vehicle,
    deploymentCost: 20,
    movementCost: 1,
    maxHealth: 300,
    movementRange: 1,
    visibilityRange: 2,
    minAttackRange: 1,
    maxAttackRange: 1,
    numberOfAttacks: 1,
    damageInfantry: 40,
    damageVehicle: 150,
    damageAir: 150,
    damageHarvester: 100,
    damageStructure: 80,
    sprite: Assets.IMAGES_UNITS_VEHICLE,
    spriteScale: 0.6,
    thumbnail: Assets.IMAGES_UNITS_VEHICLE,
  ),
  aircraft(
    unitClass: UnitClass.aircraft,
    deploymentCost: 50,
    movementCost: 1,
    maxHealth: 150,
    movementRange: 1,
    visibilityRange: 3,
    minAttackRange: 1,
    maxAttackRange: 2,
    numberOfAttacks: 1,
    damageInfantry: 100,
    damageVehicle: 40,
    damageAir: 0,
    damageHarvester: 40,
    damageStructure: 40,
    sprite: Assets.IMAGES_UNITS_AIRCRAFT,
    spriteScale: 0.4,
    thumbnail: Assets.IMAGES_UNITS_AIRCRAFT,
  );

  final UnitClass unitClass;
  final int deploymentCost;
  final int movementCost;
  final int maxHealth;
  final int visibilityRange;
  final int movementRange;
  final int minAttackRange;
  final int maxAttackRange;
  final int numberOfAttacks;
  final int damageInfantry;
  final int damageVehicle;
  final int damageAir;
  final int damageHarvester;
  final int damageStructure;
  final String sprite;
  final double spriteScale;
  final String thumbnail;

  const UnitType({
    required this.unitClass,
    required this.deploymentCost,
    required this.movementCost,
    required this.maxHealth,
    required this.movementRange,
    required this.visibilityRange,
    required this.minAttackRange,
    required this.maxAttackRange,
    required this.numberOfAttacks,
    required this.damageInfantry,
    required this.damageVehicle,
    required this.damageAir,
    required this.damageHarvester,
    required this.damageStructure,
    required this.sprite,
    required this.spriteScale,
    required this.thumbnail,
  });

  int damageAgainst(UnitClass unitClass) {
    final int maxDamage = max(max(damageInfantry, damageVehicle), damageAir);

    switch (unitClass) {
      case UnitClass.infantry:
        return _relativeDamage(damageInfantry, maxDamage);
      case UnitClass.vehicle:
        return _relativeDamage(damageVehicle, maxDamage);
      case UnitClass.aircraft:
        return _relativeDamage(damageAir, maxDamage);
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
