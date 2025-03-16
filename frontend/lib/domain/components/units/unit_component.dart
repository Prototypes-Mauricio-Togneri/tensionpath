import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';

class UnitComponent<U extends Unit> extends PositionComponent
    with CollisionCallbacks, HasGameRef {
  final U unit;
  final Paint backgroundHealthPaint = Paint();
  final Paint foregroundHealthPaint = Paint();

  UnitComponent({required this.unit, required super.size})
    : super(anchor: Anchor.center, priority: Priority.unit.value) {
    position = unit.position;
  }

  @override
  FutureOr onLoad() {
    if (unit.owner.isEnemy) {
      angle = pi;
    }

    backgroundHealthPaint.color = Colors.grey;
    foregroundHealthPaint.color = Colors.green;

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) &&
        unit.owner.isSelf &&
        other.unit.owner.isEnemy) {
      engine.onUnitsCollided(unit1: unit, unit2: other.unit);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position.setFrom(unit.position);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(0, height + 10, width, 10),
      backgroundHealthPaint,
    );

    final double healthBar = width * (unit.health / unit.maxHealth);

    if (unit.owner.isEnemy) {
      canvas.drawRect(
        Rect.fromLTWH(width - healthBar, height + 10, healthBar, 10),
        foregroundHealthPaint,
      );
    } else {
      canvas.drawRect(
        Rect.fromLTWH(0, height + 10, healthBar, 10),
        foregroundHealthPaint,
      );
    }

    super.render(canvas);
  }
}
