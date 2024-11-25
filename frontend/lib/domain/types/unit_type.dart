import 'package:tensionpath/domain/types/weapon_type.dart';

enum UnitType {
  ranger(
    cost: 1,
    health: 100,
    speedRatio: 1,
    rangeRatio: 3,
    sizeRatio: 0.5,
    weaponType: WeaponType.shooter,
  ),
  squad(
    cost: 2,
    health: 200,
    speedRatio: 1,
    rangeRatio: 3.5,
    sizeRatio: 0.5,
    weaponType: WeaponType.shooter,
  ),
  sniper(
    cost: 3,
    health: 300,
    speedRatio: 1,
    rangeRatio: 4,
    sizeRatio: 0.5,
    weaponType: WeaponType.shooter,
  ),
  tank(
    cost: 4,
    health: 400,
    speedRatio: 1,
    rangeRatio: 4.5,
    sizeRatio: 0.5,
    weaponType: WeaponType.shooter,
  ),
  kamikaze(
    cost: 5,
    health: 500,
    speedRatio: 1,
    rangeRatio: 5,
    sizeRatio: 0.5,
    weaponType: WeaponType.shooter,
  ),
  ion_canon(
    cost: 6,
    health: 600,
    speedRatio: 1,
    rangeRatio: 5.5,
    sizeRatio: 0.5,
    weaponType: WeaponType.shooter,
  );

  final int cost;
  final double health;
  final double speedRatio;
  final double rangeRatio;
  final double sizeRatio;
  final WeaponType weaponType;

  const UnitType({
    required this.cost,
    required this.health,
    required this.speedRatio,
    required this.rangeRatio,
    required this.sizeRatio,
    required this.weaponType,
  });
}
