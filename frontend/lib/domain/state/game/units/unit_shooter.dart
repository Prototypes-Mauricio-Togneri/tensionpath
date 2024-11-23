import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/types/unit_state.dart';

class UnitShooter extends Unit {
  final int power;

  UnitShooter({
    required super.hp,
    required super.speed,
    required super.range,
    required this.power,
    required super.owner,
    required super.lane,
    required super.nodes,
    required super.startingPosition,
  });

  @override
  bool get canMove => (target == null) || (target!.lane != lane);

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
