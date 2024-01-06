import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/damage.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';

class DamageComponent extends SpriteComponent with CollisionCallbacks {
  final Damage damage;

  DamageComponent({
    required this.damage,
    required super.size,
  }) : super(
          sprite: damage.sprite,
          position: damage.position,
          anchor: Anchor.center,
          priority: Priority.damages.value,
        );

  @override
  FutureOr onLoad() {
    add(circleHitbox);

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    // TODO(momo): implement

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    damage.update(dt);

    position = damage.position;
  }
}
