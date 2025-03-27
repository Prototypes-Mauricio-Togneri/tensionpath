import 'package:tensionpath/utils/assets.dart';

enum UnitType {
  rifle_squad(
    cost: 1,
    health: 100,
    attack: 10,
    range: 3,
    sprite: Assets.IMAGES_UNITS_RIFLE_SQUAD,
  ),
  sniper(
    cost: 2,
    health: 100,
    attack: 10,
    range: 3,
    sprite: Assets.IMAGES_UNITS_SNIPER,
  ),
  humvee(
    cost: 3,
    health: 100,
    attack: 10,
    range: 3,
    sprite: Assets.IMAGES_UNITS_HUMVEE,
  ),
  tank(
    cost: 4,
    health: 100,
    attack: 10,
    range: 3,
    sprite: Assets.IMAGES_UNITS_TANK,
  ),
  artillery(
    cost: 5,
    health: 100,
    attack: 10,
    range: 3,
    sprite: Assets.IMAGES_UNITS_ARTILLERY,
  ),
  helicopter(
    cost: 6,
    health: 100,
    attack: 10,
    range: 3,
    sprite: Assets.IMAGES_UNITS_HELICOPTER,
  );

  final int cost;
  final double health;
  final double attack;
  final double range;
  final String sprite;

  const UnitType({
    required this.cost,
    required this.health,
    required this.attack,
    required this.range,
    required this.sprite,
  });
}
