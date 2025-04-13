import 'package:tensionpath/utils/assets.dart';

enum UnitType {
  rifle_squad(
    deploymentCost: 1,
    movementCost: 1,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 1,
    attackRange: 1,
    sprite: Assets.IMAGES_UNITS_RIFLE_SQUAD,
  ),
  sniper(
    deploymentCost: 2,
    movementCost: 1,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 1,
    attackRange: 1,
    sprite: Assets.IMAGES_UNITS_SNIPER,
  ),
  humvee(
    deploymentCost: 3,
    movementCost: 2,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 1,
    attackRange: 1,
    sprite: Assets.IMAGES_UNITS_HUMVEE,
  ),
  tank(
    deploymentCost: 4,
    movementCost: 2,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 1,
    attackRange: 1,
    sprite: Assets.IMAGES_UNITS_TANK,
  ),
  artillery(
    deploymentCost: 5,
    movementCost: 2,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 1,
    attackRange: 1,
    sprite: Assets.IMAGES_UNITS_ARTILLERY,
  ),
  helicopter(
    deploymentCost: 6,
    movementCost: 3,
    maxHealth: 100,
    movementRange: 1,
    visibilityRange: 1,
    attackRange: 1,
    sprite: Assets.IMAGES_UNITS_HELICOPTER,
  );

  final int deploymentCost;
  final int movementCost;
  final int maxHealth;
  final int visibilityRange;
  final int movementRange;
  final int attackRange;
  final String sprite;

  const UnitType({
    required this.deploymentCost,
    required this.movementCost,
    required this.maxHealth,
    required this.movementRange,
    required this.visibilityRange,
    required this.attackRange,
    required this.sprite,
  });
}
