import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/state/game/weapon.dart';
import 'package:tensionpath/domain/types/unit_state.dart';
import 'package:tensionpath/domain/types/weapon_type.dart';

class UnitShooter extends Unit {
  late final Weapon weapon;

  UnitShooter({
    required super.health,
    required super.speed,
    required super.range,
    required super.owner,
    required super.lane,
    required super.nodes,
    required super.startingPosition,
    required WeaponType weaponType,
  }) {
    weapon = Weapon.fromType(
      unit: this,
      weaponType: weaponType,
    );
  }

  @override
  bool get canMove => (target == null) || (target!.lane != lane);

  @override
  void update(double dt) {
    if ((target == null) || (target!.state == UnitState.dead)) {
      target = findTarget();
    }

    if ((target != null) && weapon.canShoot) {
      weapon.shpot(target: target!);
    }

    super.update(dt);
  }

  Unit? findTarget() => engine.findTarget(
        source: this,
        distance: range,
      );

  @override
  UnitShooterComponent component(double maxUnitSize) => UnitShooterComponent(
        unit: this,
        size: Vector2(maxUnitSize, maxUnitSize),
      );
}
