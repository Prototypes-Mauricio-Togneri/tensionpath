import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';

class NodeCapturableComponent extends NodeComponent with CollisionCallbacks {
  final Paint backgroundPaint = Paint();
  final Paint ownershipNormalPaint = Paint();
  final Paint ownershipNeonPaint = Paint();
  final Paint borderNormalPaint = Paint();
  final Paint borderNeonPaint = Paint();

  NodeCapturableComponent({
    required super.node,
    required super.position,
    required super.size,
  }) {
    ownershipNormalPaint.style = PaintingStyle.stroke;
    ownershipNormalPaint.strokeWidth = 10;

    ownershipNeonPaint.style = PaintingStyle.stroke;
    ownershipNeonPaint.strokeWidth = 10;
    ownershipNeonPaint.maskFilter = MaskFilter.blur(
      BlurStyle.normal,
      ownershipNeonPaint.strokeWidth * Constants.NEON_EFFECT,
    );

    borderNormalPaint.style = PaintingStyle.stroke;
    borderNormalPaint.strokeWidth = 5;

    borderNeonPaint.style = PaintingStyle.stroke;
    borderNeonPaint.strokeWidth = 5;
    borderNeonPaint.maskFilter = MaskFilter.blur(
      BlurStyle.normal,
      borderNeonPaint.strokeWidth * Constants.NEON_EFFECT,
    );
  }

  @override
  FutureOr onLoad() {
    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is UnitComponent) {
      node.onTouched(other.unit);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (node.hasOwner) {
      if (node.owner!.isEnemy) {
        backgroundPaint.color = Colors.red.withAlpha(100);
        borderNormalPaint.color = Colors.red;
        borderNeonPaint.color = Colors.red;
      } else if (node.owner!.isSelf) {
        backgroundPaint.color = Colors.blue.withAlpha(100);
        borderNormalPaint.color = Colors.blue;
        borderNeonPaint.color = Colors.blue;
      }
    } else {
      backgroundPaint.color = Colors.transparent;
      borderNormalPaint.color = Colors.white;
      borderNeonPaint.color = Colors.white;
    }
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
      borderNormalPaint,
    );

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      borderNeonPaint,
    );

    if (node.hasTouched) {
      ownershipNormalPaint.color = node.color;
      ownershipNeonPaint.color = node.color;

      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.x, size.y),
        -pi / 2,
        2 * pi * node.ownershipValue,
        false,
        ownershipNormalPaint,
      );

      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.x, size.y),
        -pi / 2,
        2 * pi * node.ownershipValue,
        false,
        ownershipNeonPaint,
      );
    }
  }
}
