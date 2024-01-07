import 'package:flame/components.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/types/projectile_effect.dart';
import 'package:tensionpath/utils/sprites.dart';

class ProjectileSpecs {
  final UnitComponent target;
  final double attackPower;
  final ProjectileEffect effect;
  final Vector2 position;

  const ProjectileSpecs({
    required this.target,
    required this.attackPower,
    required this.effect,
    required this.position,
  });

  Sprite get sprite => Sprites.NODE_ENEMY; // TODO(momo): update

  void update(double dt) {}
}
