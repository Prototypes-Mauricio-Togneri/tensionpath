import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/weapon_type.dart';
import 'package:tensionpath/utils/assets.dart';

enum UnitType {
  fuel_truck(
    unitClass: UnitClass.land,
    deploymentCost: 1,
    movementCost: 1,
    maxHealth: 3400,
    movementRange: 1,
    visibilityRange: 1,
    attackRange: 0,
    numberOfAttacks: 0,
    weapoinType: WeaponType.none,
    attackValue: 0,
    sprite: 'fuel_truck',
    thumbnail: Assets.IMAGES_THUMBNAILS_FUEL_TRUCK,
  ),
  rifle_squad(
    unitClass: UnitClass.land,
    deploymentCost: 1,
    movementCost: 1,
    maxHealth: 130,
    movementRange: 1,
    visibilityRange: 3,
    attackRange: 1,
    numberOfAttacks: 1,
    weapoinType: WeaponType.bullet,
    attackValue: 40,
    sprite: 'rifle_squad',
    thumbnail: Assets.IMAGES_THUMBNAILS_RIFLE_SQUAD,
  ),
  rpg_team(
    unitClass: UnitClass.land,
    deploymentCost: 1,
    movementCost: 1,
    maxHealth: 220,
    movementRange: 1,
    visibilityRange: 2,
    attackRange: 1,
    numberOfAttacks: 1,
    weapoinType: WeaponType.missile,
    attackValue: 250,
    sprite: 'rpg_team',
    thumbnail: Assets.IMAGES_THUMBNAILS_RPG_TEAM,
  ),
  sniper(
    unitClass: UnitClass.land,
    deploymentCost: 2,
    movementCost: 1,
    maxHealth: 250,
    movementRange: 1,
    visibilityRange: 3,
    attackRange: 1,
    numberOfAttacks: 1,
    weapoinType: WeaponType.bullet,
    attackValue: 100,
    sprite: 'sniper',
    thumbnail: Assets.IMAGES_THUMBNAILS_SNIPER,
  ),
  humvee(
    unitClass: UnitClass.land,
    deploymentCost: 3,
    movementCost: 2,
    maxHealth: 1500,
    movementRange: 1,
    visibilityRange: 3,
    attackRange: 1,
    numberOfAttacks: 1,
    weapoinType: WeaponType.bullet,
    attackValue: 80,
    sprite: 'humvee',
    thumbnail: Assets.IMAGES_THUMBNAILS_HUMVEE,
  ),
  rocket_vehicle(
    unitClass: UnitClass.land,
    deploymentCost: 3,
    movementCost: 2,
    maxHealth: 1600,
    movementRange: 1,
    visibilityRange: 2,
    attackRange: 1,
    numberOfAttacks: 1,
    weapoinType: WeaponType.missile,
    attackValue: 250,
    sprite: 'rocket_vehicle',
    thumbnail: Assets.IMAGES_THUMBNAILS_ROCKET_VEHICLE,
  ),
  tank(
    unitClass: UnitClass.land,
    deploymentCost: 4,
    movementCost: 2,
    maxHealth: 2800,
    movementRange: 1,
    visibilityRange: 2,
    attackRange: 1,
    numberOfAttacks: 1,
    weapoinType: WeaponType.cannon,
    attackValue: 800,
    sprite: 'tank',
    thumbnail: Assets.IMAGES_THUMBNAILS_TANK,
  ),
  artillery(
    unitClass: UnitClass.land,
    deploymentCost: 5,
    movementCost: 2,
    maxHealth: 1500,
    movementRange: 1,
    visibilityRange: 2,
    attackRange: 2,
    numberOfAttacks: 1,
    weapoinType: WeaponType.bomb,
    attackValue: 600,
    sprite: 'artillery',
    thumbnail: Assets.IMAGES_THUMBNAILS_ARTILLERY,
  ),
  helicopter(
    unitClass: UnitClass.air,
    deploymentCost: 6,
    movementCost: 3,
    maxHealth: 900,
    movementRange: 1,
    visibilityRange: 3,
    attackRange: 1,
    numberOfAttacks: 1,
    weapoinType: WeaponType.bullet,
    attackValue: 350,
    sprite: 'helicopter',
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
  final WeaponType weapoinType;
  final int attackValue;
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
    required this.weapoinType,
    required this.attackValue,
    required this.sprite,
    required this.thumbnail,
  });
}
