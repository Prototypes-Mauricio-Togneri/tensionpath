import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/state/game/weapon.dart';
import 'package:tensionpath/domain/types/weapon_type.dart';

class UnitShooter extends Unit {
  late final Weapon weapon;

  UnitShooter({
    required super.maxHealth,
    required super.speed,
    required super.range,
    required super.size,
    required super.owner,
    required super.nodes,
    required super.startingPosition,
    required WeaponType weaponType,
  }) {
    weapon = Weapon.fromType(unit: this, weaponType: weaponType);
  }

  @override
  bool get canMove => target == null;

  @override
  void update(double dt) {
    weapon.update(dt);
    
    if ((target != null) && weapon.canShoot) {
      weapon.shoot(target: target!);
    }

    super.update(dt);
  }

  @override
  UnitShooterComponent get component =>
      UnitShooterComponent(unit: this, size: Vector2(size, size));
}
