import 'package:tensionpath/domain/types/target_type.dart';

class WeaponSpecs {
  final int amountOfProjectiles;
  final double attackSpeed;
  final double range;
  final List<TargetType> targetTypes;

  static const WeaponSpecs NORMAL = WeaponSpecs(
    amountOfProjectiles: 1,
    attackSpeed: 0.5,
    range: 5,
    targetTypes: [TargetType.air],
  );

  static const WeaponSpecs SHOTGUN = WeaponSpecs(
    amountOfProjectiles: 5,
    attackSpeed: 0.5,
    range: 2,
    targetTypes: [TargetType.air],
  );

  static const WeaponSpecs SNIPER = WeaponSpecs(
    amountOfProjectiles: 1,
    attackSpeed: 3,
    range: 8,
    targetTypes: [TargetType.air],
  );

  static const WeaponSpecs MINIGUN = WeaponSpecs(
    amountOfProjectiles: 1,
    attackSpeed: 0.2,
    range: 5,
    targetTypes: [TargetType.air],
  );

  const WeaponSpecs({
    required this.amountOfProjectiles,
    required this.attackSpeed,
    required this.range,
    required this.targetTypes,
  });
}
