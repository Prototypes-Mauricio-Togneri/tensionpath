import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_sniper_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_shooter.dart';

class UnitSniper extends UnitShooter {
  UnitSniper({
    required super.maxHealth,
    required super.speed,
    required super.range,
    required super.size,
    required super.owner,
    required super.nodes,
    required super.startingPosition,
    required super.weaponType,
  });

  @override
  UnitSniperComponent get component =>
      UnitSniperComponent(unit: this, size: Vector2(size, size));
}
