import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_ranger_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_shooter.dart';

class UnitRanger extends UnitShooter {
  UnitRanger({
    required super.maxHealth,
    required super.speed,
    required super.range,
    required super.size,
    required super.owner,
    required super.lane,
    required super.nodes,
    required super.startingPosition,
    required super.weaponType,
  });

  @override
  UnitRangerComponent get component => UnitRangerComponent(
        unit: this,
        size: Vector2(size, size),
      );
}
