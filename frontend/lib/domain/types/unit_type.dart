import 'package:tensionpath/domain/types/weapon_type.dart';

enum UnitType {
  shooter1(
    cost: 1,
    health: 100,
    speed: 100,
    range: 3,
    weaponType: WeaponType.shooter,
  ),
  shooter2(
    cost: 2,
    health: 200,
    speed: 100,
    range: 3.5,
    weaponType: WeaponType.shooter,
  ),
  shooter3(
    cost: 3,
    health: 300,
    speed: 100,
    range: 4,
    weaponType: WeaponType.shooter,
  ),
  shooter4(
    cost: 4,
    health: 400,
    speed: 100,
    range: 4.5,
    weaponType: WeaponType.shooter,
  ),
  shooter5(
    cost: 5,
    health: 500,
    speed: 100,
    range: 5,
    weaponType: WeaponType.shooter,
  ),
  shooter6(
    cost: 6,
    health: 600,
    speed: 100,
    range: 5.5,
    weaponType: WeaponType.shooter,
  );

  final int cost;
  final double health;
  final double speed;
  final double range;
  final WeaponType weaponType;

  const UnitType({
    required this.cost,
    required this.health,
    required this.speed,
    required this.range,
    required this.weaponType,
  });
}
