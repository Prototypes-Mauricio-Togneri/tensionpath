import 'package:tensionpath/domain/types/target_type.dart';

enum WeaponType {
  shooter(attackSpeed: 1, projectiles: 1, targetType: TargetType.single);

  final double attackSpeed;
  final int projectiles;
  final TargetType targetType;

  const WeaponType({
    required this.attackSpeed,
    required this.projectiles,
    required this.targetType,
  });
}
