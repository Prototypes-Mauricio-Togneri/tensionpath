import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/game/nodes/node_base_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_capturable.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeCapturableComponent<T extends NodeCapturable>
    extends NodeBaseComponent<T> with CollisionCallbacks {
  final Paint ownershipPaint = Paint();

  NodeCapturableComponent({
    required super.node,
    required super.size,
  }) {
    ownershipPaint.style = PaintingStyle.stroke;
    ownershipPaint.strokeWidth = 10;
  }

  @override
  FutureOr onLoad() {
    add(circleHitbox);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    final bool shouldUpdate = node.update(dt);

    if (shouldUpdate) {
      if (node.hasOwner) {
        if (node.owner!.isEnemy) {
          sprite = Sprites.NODE_ENEMY;
        } else if (node.owner!.isSelf) {
          sprite = Sprites.NODE_SELF;
        }
      } else {
        sprite = Sprites.NODE_NEUTRAL;
      }
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is UnitComponent) {
      node.onTouched(other.owner);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (node.ownership.hasTouched) {
      ownershipPaint.color = node.ownership.color;

      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.x, size.y),
        -pi / 2,
        2 * pi * node.ownership.value,
        false,
        ownershipPaint,
      );
    }
  }
}
