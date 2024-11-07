import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';

class NodeCapturableComponent extends NodeComponent with CollisionCallbacks {
  final Paint ownershipPaint = Paint();
  final Paint backgroundPaint = Paint();
  final Paint borderPaint = Paint();

  NodeCapturableComponent({
    required super.node,
    required super.rate,
    required super.position,
    required super.size,
    super.owner,
  }) {
    ownershipPaint.style = PaintingStyle.stroke;
    ownershipPaint.strokeWidth = 10;

    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeWidth = 5;
  }

  @override
  FutureOr onLoad() {
    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (hasOwner) {
      if (owner!.isEnemy) {
        backgroundPaint.color = Colors.red.withAlpha(100);
        borderPaint.color = Colors.red;
      } else if (owner!.isSelf) {
        backgroundPaint.color = Colors.blue.withAlpha(100);
        borderPaint.color = Colors.blue;
      }
    } else {
      backgroundPaint.color = Colors.transparent;
      borderPaint.color = Colors.white;
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

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      backgroundPaint,
    );

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      borderPaint,
    );

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
