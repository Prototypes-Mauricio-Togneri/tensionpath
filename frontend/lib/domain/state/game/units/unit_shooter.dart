import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';

class UnitShooter extends Unit {
  int power;

  UnitShooter({
    required super.hp,
    required super.speed,
    required this.power,
    required super.owner,
    required super.lane,
    required super.nodes,
    required super.startingPosition,
  });

  @override
  UnitShooterComponent component(double maxUnitSize) => UnitShooterComponent(
        unit: this,
        size: Vector2(maxUnitSize, maxUnitSize),
      );
}
