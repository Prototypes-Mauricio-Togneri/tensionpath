import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/explosion_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/assets.dart';

class MissileComponent extends SpriteComponent {
  final Player player;
  final num damage;
  final Vector2 targetPosition;

  MissileComponent({
    required super.position,
    required super.size,
    required this.player,
    required this.damage,
    required this.targetPosition,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.missile.value,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_OTHER_MISSILE);
    final Image image = sprite!.image;

    if (image.width > image.height) {
      size.y = size.x * (image.height.toDouble() / image.width.toDouble());
    } else {
      size.x = size.y * (image.width.toDouble() / image.height.toDouble());
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final Vector2 direction = (targetPosition - absolutePosition).normalized();
    final double speed = size.x * 10;
    final double deltaDistance = speed * dt;
    position += direction * deltaDistance;
    angle = direction.angleTo(targetPosition);

    final num distance = absolutePosition.distanceTo(targetPosition);

    if (distance < (deltaDistance / 2)) {
      final ExplosionComponent explosionComponent = ExplosionComponent(
        position: targetPosition,
        size: size,
      );
      match.add(explosionComponent);
      player.onHit(damage);
      removeFromParent();
    }
  }
}
