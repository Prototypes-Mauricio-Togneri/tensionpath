import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/utils/assets.dart';

enum UnitType {
  fuel_truck(
    unitClass: UnitClass.land,
    deploymentCost: 1,
    movementCost: 1,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 1,
    attackRange: 0,
    numberOfAttacks: 0,
    sprite: Assets.IMAGES_UNITS_FUEL_TRUCK,
    thumbnail: Assets.IMAGES_THUMBNAILS_FUEL_TRUCK,
  ),
  rifle_squad(
    unitClass: UnitClass.land,
    deploymentCost: 1,
    movementCost: 1,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 3,
    attackRange: 1,
    numberOfAttacks: 1,
    sprite: Assets.IMAGES_UNITS_RIFLE_SQUAD,
    thumbnail: Assets.IMAGES_THUMBNAILS_RIFLE_SQUAD,
  ),
  rpg_team(
    unitClass: UnitClass.land,
    deploymentCost: 1,
    movementCost: 1,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 2,
    attackRange: 1,
    numberOfAttacks: 1,
    sprite: Assets.IMAGES_UNITS_RPG_TEAM,
    thumbnail: Assets.IMAGES_THUMBNAILS_RPG_TEAM,
  ),
  sniper(
    unitClass: UnitClass.land,
    deploymentCost: 2,
    movementCost: 1,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 3,
    attackRange: 1,
    numberOfAttacks: 1,
    sprite: Assets.IMAGES_UNITS_SNIPER,
    thumbnail: Assets.IMAGES_THUMBNAILS_SNIPER,
  ),
  humvee(
    unitClass: UnitClass.land,
    deploymentCost: 3,
    movementCost: 2,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 3,
    attackRange: 1,
    numberOfAttacks: 1,
    sprite: Assets.IMAGES_UNITS_HUMVEE,
    thumbnail: Assets.IMAGES_THUMBNAILS_HUMVEE,
  ),
  rocket_vehicle(
    unitClass: UnitClass.land,
    deploymentCost: 3,
    movementCost: 2,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 2,
    attackRange: 1,
    numberOfAttacks: 1,
    sprite: Assets.IMAGES_UNITS_ROCKET_VEHICLE,
    thumbnail: Assets.IMAGES_THUMBNAILS_ROCKET_VEHICLE,
  ),
  tank(
    unitClass: UnitClass.land,
    deploymentCost: 4,
    movementCost: 2,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 2,
    attackRange: 1,
    numberOfAttacks: 1,
    sprite: Assets.IMAGES_UNITS_TANK,
    thumbnail: Assets.IMAGES_THUMBNAILS_TANK,
  ),
  artillery(
    unitClass: UnitClass.land,
    deploymentCost: 5,
    movementCost: 2,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 2,
    attackRange: 1,
    numberOfAttacks: 1,
    sprite: Assets.IMAGES_UNITS_ARTILLERY,
    thumbnail: Assets.IMAGES_THUMBNAILS_ARTILLERY,
  ),
  helicopter(
    unitClass: UnitClass.air,
    deploymentCost: 6,
    movementCost: 3,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 3,
    attackRange: 1,
    numberOfAttacks: 1,
    sprite: Assets.IMAGES_UNITS_HELICOPTER,
    thumbnail: Assets.IMAGES_THUMBNAILS_HELICOPTER,
  );

  final UnitClass unitClass;
  final int deploymentCost;
  final int movementCost;
  final int maxHealth;
  final int visibilityRange;
  final int movementRange;
  final int attackRange;
  final int numberOfAttacks;
  final String sprite;
  final String thumbnail;

  const UnitType({
    required this.unitClass,
    required this.deploymentCost,
    required this.movementCost,
    required this.maxHealth,
    required this.movementRange,
    required this.visibilityRange,
    required this.attackRange,
    required this.numberOfAttacks,
    required this.sprite,
    required this.thumbnail,
  });
}
