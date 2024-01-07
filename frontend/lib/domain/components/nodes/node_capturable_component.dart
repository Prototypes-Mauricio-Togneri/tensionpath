import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeCapturableComponent extends NodeComponent with CollisionCallbacks {
  final Paint ownershipPaint = Paint();

  NodeCapturableComponent({
    required super.id,
    required super.rate,
    required super.position,
    required super.size,
    super.owner,
  }) {
    ownershipPaint.style = PaintingStyle.stroke;
    ownershipPaint.strokeWidth = 10;
  }

  @override
  Sprite get sprite {
    if (owner == null) {
      return Sprites.NODE_NEUTRAL;
    } else if (owner!.isEnemy) {
      return Sprites.NODE_ENEMY;
    } else if (owner!.isSelf) {
      return Sprites.NODE_SELF;
    }

    throw Exception('Cannot determine node sprite');
  }

  @override
  FutureOr onLoad() {
    add(circleHitbox);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (hasOwner) {
      if (owner!.isEnemy) {
        sprite = Sprites.NODE_ENEMY;
      } else if (owner!.isSelf) {
        sprite = Sprites.NODE_SELF;
      }
    } else {
      sprite = Sprites.NODE_NEUTRAL;
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is UnitComponent) {
      ownership.touched(other.owner);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (ownership.hasTouched) {
      ownershipPaint.color = ownership.color;

      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.x, size.y),
        -pi / 2,
        2 * pi * ownership.value,
        false,
        ownershipPaint,
      );
    }
  }
}
