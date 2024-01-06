import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/types/projectile_effect.dart';
import 'package:tensionpath/utils/sprites.dart';

class Projectile {
  final Unit target;
  final ProjectileEffect effect;
  final Vector2 position;

  const Projectile({
    required this.target,
    required this.effect,
    required this.position,
  });

  Sprite get sprite => Sprites.NODE_ENEMY; // TODO(momo): update

  void update(double dt) {}
}
