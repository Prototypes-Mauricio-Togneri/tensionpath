import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

extension SpriteComponentExtension on SpriteComponent {
  CircleHitbox get circleHitbox => CircleHitbox(
        radius: size.x / 2,
        position: size / 2,
        anchor: Anchor.center,
        isSolid: true,
      );
}
