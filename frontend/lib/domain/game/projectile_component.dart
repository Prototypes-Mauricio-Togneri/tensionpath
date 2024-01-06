import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/projectile.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';

class ProjectileComponent extends SpriteComponent with CollisionCallbacks {
  final Projectile projectile;

  ProjectileComponent({
    required this.projectile,
    required super.size,
  }) : super(
          sprite: projectile.sprite,
          position: projectile.position,
          anchor: Anchor.center,
          priority: Priority.projectiles.value,
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
    projectile.update(dt);

    position = projectile.position;
  }
}
