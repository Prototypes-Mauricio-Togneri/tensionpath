import 'package:tensionpath/domain/components/target.dart';
import 'package:tensionpath/domain/state/game/units/unit_shooter.dart';
import 'package:tensionpath/domain/types/target_type.dart';
import 'package:tensionpath/domain/types/weapon_type.dart';

class Weapon {
  final UnitShooter unit;
  final double attackSpeed;
  final int projectiles;
  final TargetType targetType;
  double reloading = 0;

  Weapon({
    required this.unit,
    required this.attackSpeed,
    required this.projectiles,
    required this.targetType,
  });

  bool get canShoot => reloading <= 0;

  void update(double dt) {
    if (reloading > 0) {
      reloading -= dt * attackSpeed;
    }
  }

  void shoot({required Target target}) {
    target.onHit(10);
    reloading = attackSpeed;
  }

  factory Weapon.fromType({
    required UnitShooter unit,
    required WeaponType weaponType,
  }) => Weapon(
    unit: unit,
    attackSpeed: weaponType.attackSpeed,
    projectiles: weaponType.projectiles,
    targetType: weaponType.targetType,
  );
}
