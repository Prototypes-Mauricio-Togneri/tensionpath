import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';

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
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) &&
        unit.owner.isSelf &&
        other.unit.owner.isEnemy) {
      engine.onUnitsCollided(
        unit1: unit,
        unit2: other.unit,
      );
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position.setFrom(unit.position);
  }
}
