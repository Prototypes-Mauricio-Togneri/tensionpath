import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/weapon.dart';

class WeaponComponent extends PositionComponent {
  final Weapon weapon;

  WeaponComponent({
    required this.weapon,
    required super.position,
  }) : super(
          anchor: Anchor.center,
        );
}
