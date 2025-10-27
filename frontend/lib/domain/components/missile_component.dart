import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/explosion_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/assets.dart';

class MissileComponent extends SpriteComponent {
  final Player player;
  final num damage;
  final Vector2 targetPosition;
  late final Vector2 direction;
  late final double speed;

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

    direction = (targetPosition - absolutePosition).normalized();
    speed = size.x * 10;
    angle = absolutePosition.angleTo(targetPosition);
    angle -= 45 * (pi / 180); // Adjust for missile sprite orientation

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final double deltaDistance = speed * dt;
    position += direction * deltaDistance;
    final num distance = absolutePosition.distanceTo(targetPosition);

    if (distance < (deltaDistance * 2)) {
      final double maxSize = max(size.x, size.y);
      final ExplosionComponent explosionComponent = ExplosionComponent(
        position: targetPosition,
        size: Vector2(maxSize, maxSize),
      );
      match.add(explosionComponent);
      player.onHit(damage);
      Audio.get.playSound(Sound.EFFECT_MISSILE_IMPACT);
      removeFromParent();
    }
  }
}
