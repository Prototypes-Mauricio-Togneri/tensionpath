import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/specs/weapon_specs.dart';

class WeaponComponent extends PositionComponent {
  final WeaponSpecs weapon;

  WeaponComponent({
    required this.weapon,
    required super.position,
  }) : super(
          anchor: Anchor.center,
        );
}
