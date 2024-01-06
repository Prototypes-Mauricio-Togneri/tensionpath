import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/damage_type.dart';
import 'package:tensionpath/utils/sprites.dart';

class Damage {
  final DamageType type;
  final Vector2 position;
  final double radius;
  final double expansionRate;

  const Damage({
    required this.type,
    required this.position,
    required this.radius,
    required this.expansionRate,
  });

  Sprite get sprite => Sprites.NODE_ENEMY; // TODO(momo): update

  void update(double dt) {}
}
