import 'package:tensionpath/domain/types/target_type.dart';

class Weapon {
  final int amountOfProjectiles;
  final double attackSpeed;
  final double range;
  final List<TargetType> targetTypes;

  static const Weapon NORMAL = Weapon(
    amountOfProjectiles: 1,
    attackSpeed: 0.5,
    range: 5,
    targetTypes: [TargetType.air],
  );

  static const Weapon SHOTGUN = Weapon(
    amountOfProjectiles: 5,
    attackSpeed: 0.5,
    range: 2,
    targetTypes: [TargetType.air],
  );

  static const Weapon SNIPER = Weapon(
    amountOfProjectiles: 1,
    attackSpeed: 3,
    range: 8,
    targetTypes: [TargetType.air],
  );

  static const Weapon MINIGUN = Weapon(
    amountOfProjectiles: 1,
    attackSpeed: 0.2,
    range: 5,
    targetTypes: [TargetType.air],
  );

  const Weapon({
    required this.amountOfProjectiles,
    required this.attackSpeed,
    required this.range,
    required this.targetTypes,
  });
}
