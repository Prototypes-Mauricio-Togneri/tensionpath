import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';

class UnitComponent<U extends Unit> extends PositionComponent
    with CollisionCallbacks, HasGameRef {
  final U unit;

  UnitComponent({
    required this.unit,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.unit.value,
        ) {
    position = unit.position;
  }

  @override
  void update(double dt) {
    position.setFrom(unit.position);
  }
}
