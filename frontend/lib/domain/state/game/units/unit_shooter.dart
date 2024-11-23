import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/types/unit_state.dart';

class UnitShooter extends Unit {
  final int power;
  final double range;
  Unit? target;

  UnitShooter({
    required super.hp,
    required super.speed,
    required this.power,
    required this.range,
    required super.owner,
    required super.lane,
    required super.nodes,
    required super.startingPosition,
  });

  @override
  bool get canMove => target == null;

  @override
  void update(double dt) {
    if ((target == null) || (target!.state == UnitState.dead)) {
      target = findTarget();
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
