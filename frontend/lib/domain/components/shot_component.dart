import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/explosion_component.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class ShotToUnitComponent extends PositionComponent {
  late Vector2 currentPosition;
  final UnitComponent attackerUnit;
  final UnitComponent targetUnit;
  final num damage;
  final bool targetDestroyed;
  late final double speed;
  late final double threshold;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
  );

  ShotToUnitComponent({
    required super.position,
    required super.size,
    required this.attackerUnit,
    required this.targetUnit,
    required this.damage,
    required this.targetDestroyed,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.shot.value,
       ) {
    fillPaint.color = attackerUnit.player.color;
    currentPosition = attackerUnit.absolutePosition;
    speed = size.x * 80;
    threshold = 0.03 * speed;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (targetUnit.isRemoved) {
      onTargetUnitHit();
    } else {
      final Vector2 direction = (targetUnit.absolutePosition - currentPosition)
          .normalized();
      currentPosition += direction * speed * dt;

      final num distance = currentPosition.distanceTo(
        targetUnit.absolutePosition,
      );

      if (distance < threshold) {
        onTargetUnitHit();
      }
    }
  }

  void onTargetUnitHit() {
    final ExplosionComponent explosionComponent = ExplosionComponent(
      position: targetUnit.absolutePosition,
      size: targetDestroyed ? targetUnit.size * 0.5 : size * 3,
    );
    match.add(explosionComponent);

    removeFromParent();
    targetUnit.onUnitAttacked(damage);

    if (targetDestroyed) {
      match.onUnitDestroyed(targetUnit);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      currentPosition.toOffset(),
      size.x / 2,
      fillPaint,
    );
  }
}

class ShotToBaseComponent extends PositionComponent {
  late Vector2 currentPosition;
  final UnitComponent attackerUnit;
  final LauncherComponent targetBase;
  final num damage;
  late final double speed;
  late final double threshold;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
  );

  ShotToBaseComponent({
    required super.position,
    required super.size,
    required this.attackerUnit,
    required this.targetBase,
    required this.damage,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.shot.value,
       ) {
    fillPaint.color = attackerUnit.player.color;
    currentPosition = attackerUnit.absolutePosition;
    speed = size.x * 80;
    threshold = 0.03 * speed;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (targetBase.isRemoved) {
      onTargetBaseHit();
    } else {
      final Vector2 direction = (targetBase.absolutePosition - currentPosition)
          .normalized();
      currentPosition += direction * speed * dt;

      final num distance = currentPosition.distanceTo(
        targetBase.absolutePosition,
      );

      if (distance < threshold) {
        onTargetBaseHit();
      }
    }
  }

  void onTargetBaseHit() {
    final ExplosionComponent explosionComponent = ExplosionComponent(
      position: targetBase.absolutePosition,
      size: size * 3,
    );
    match.add(explosionComponent);

    removeFromParent();
    targetBase.player.removeBaseHealth(damage);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      currentPosition.toOffset(),
      size.x / 2,
      fillPaint,
    );
  }
}
