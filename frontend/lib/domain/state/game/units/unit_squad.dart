import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_squad_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_shooter.dart';

class UnitSquad extends UnitShooter {
  UnitSquad({
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
  UnitSquadComponent get component =>
      UnitSquadComponent(unit: this, size: Vector2(size, size));
}
