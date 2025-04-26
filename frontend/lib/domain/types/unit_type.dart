import 'dart:math';

import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/utils/assets.dart';

enum UnitType {
  fuel_truck(
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
    damageFuelTruck: 0,
    damageStructure: 0,
    spriteName: 'fuel_truck',
    spriteScale: 0.8,
    thumbnail: Assets.IMAGES_THUMBNAILS_FUEL_TRUCK,
  ),
  rifle_squad(
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
    damageFuelTruck: 50,
    damageStructure: 50,
    spriteName: 'rifle_squad',
    spriteScale: 0.5,
    thumbnail: Assets.IMAGES_THUMBNAILS_RIFLE_SQUAD,
  ),
  rpg_team(
    unitClass: UnitClass.infantry,
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
    damageFuelTruck: 100,
    damageStructure: 80,
    spriteName: 'rpg_team',
    spriteScale: 0.6,
    thumbnail: Assets.IMAGES_THUMBNAILS_RPG_TEAM,
  ),
  sniper(
    unitClass: UnitClass.infantry,
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
    damageFuelTruck: 40,
    damageStructure: 40,
    spriteName: 'sniper',
    spriteScale: 0.4,
    thumbnail: Assets.IMAGES_THUMBNAILS_SNIPER,
  ),
  humvee(
    unitClass: UnitClass.vehicle,
    deploymentCost: 30,
    movementCost: 2,
    maxHealth: 500,
    movementRange: 1,
    visibilityRange: 3,
    minAttackRange: 1,
    maxAttackRange: 1,
    numberOfAttacks: 1,
    damageInfantry: 100,
    damageVehicle: 80,
    damageAir: 100,
    damageFuelTruck: 80,
    damageStructure: 80,
    spriteName: 'humvee',
    spriteScale: 0.6,
    thumbnail: Assets.IMAGES_THUMBNAILS_HUMVEE,
  ),
  rocket_vehicle(
    unitClass: UnitClass.vehicle,
    deploymentCost: 40,
    movementCost: 2,
    maxHealth: 600,
    movementRange: 1,
    visibilityRange: 2,
    minAttackRange: 1,
    maxAttackRange: 1,
    numberOfAttacks: 1,
    damageInfantry: 40,
    damageVehicle: 150,
    damageAir: 150,
    damageFuelTruck: 250,
    damageStructure: 100,
    spriteName: 'rocket_vehicle',
    spriteScale: 0.6,
    thumbnail: Assets.IMAGES_THUMBNAILS_ROCKET_VEHICLE,
  ),
  tank(
    unitClass: UnitClass.vehicle,
    deploymentCost: 70,
    movementCost: 2,
    maxHealth: 800,
    movementRange: 1,
    visibilityRange: 2,
    minAttackRange: 1,
    maxAttackRange: 1,
    numberOfAttacks: 1,
    damageInfantry: 50,
    damageVehicle: 200,
    damageAir: 0,
    damageFuelTruck: 300,
    damageStructure: 150,
    spriteName: 'tank',
    spriteScale: 0.8,
    thumbnail: Assets.IMAGES_THUMBNAILS_TANK,
  ),
  artillery(
    unitClass: UnitClass.vehicle,
    deploymentCost: 90,
    movementCost: 2,
    maxHealth: 400,
    movementRange: 1,
    visibilityRange: 2,
    minAttackRange: 2,
    maxAttackRange: 2,
    numberOfAttacks: 1,
    damageInfantry: 40,
    damageVehicle: 250,
    damageAir: 0,
    damageFuelTruck: 350,
    damageStructure: 200,
    spriteName: 'artillery',
    spriteScale: 0.7,
    thumbnail: Assets.IMAGES_THUMBNAILS_ARTILLERY,
  ),
  helicopter(
    unitClass: UnitClass.aircraft,
    deploymentCost: 100,
    movementCost: 3,
    maxHealth: 400,
    movementRange: 1,
    visibilityRange: 3,
    minAttackRange: 1,
    maxAttackRange: 1,
    numberOfAttacks: 1,
    damageInfantry: 100,
    damageVehicle: 100,
    damageAir: 100,
    damageFuelTruck: 100,
    damageStructure: 150,
    spriteName: 'helicopter',
    spriteScale: 0.8,
    thumbnail: Assets.IMAGES_THUMBNAILS_HELICOPTER,
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
  final int damageFuelTruck;
  final int damageStructure;
  final String spriteName;
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
    required this.damageFuelTruck,
    required this.damageStructure,
    required this.spriteName,
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
