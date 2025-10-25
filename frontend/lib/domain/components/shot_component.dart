import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/explosion_component.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/palette.dart';

class ShotToUnitComponent extends ShotComponent {
  final UnitComponent targetUnit;

  ShotToUnitComponent({
    required super.position,
    required super.size,
    required UnitComponent attackerUnit,
    required this.targetUnit,
    required num damage,
    required bool targetDestroyed,
  }) : super(
         sourceComponent: attackerUnit,
         targetComponent: targetUnit,
         damage: damage,
         targetDestroyed: targetDestroyed,
         color: attackerUnit.player.color,
       );

  @override
  void onTargetHit() {
    createExplosion();
    targetUnit.onHit(damage);

    if (targetDestroyed) {
      match.onUnitDestroyed(targetUnit);
    } else if ((targetUnit.type == UnitType.harvester) &&
        targetUnit.player.isSelf &&
        targetUnit.attackAlert.isReady) {
      Audio.get.playSound(Sound.EVA_HARVESTER_UNDER_ATTACK);
    }
  }
}

class ShotToBaseComponent extends ShotComponent {
  final LauncherComponent targetBase;

  ShotToBaseComponent({
    required super.position,
    required super.size,
    required UnitComponent attackerUnit,
    required this.targetBase,
    required num damage,
  }) : super(
         sourceComponent: attackerUnit,
         targetComponent: targetBase,
         damage: damage,
         targetDestroyed: false,
         color: attackerUnit.player.color,
       );

  @override
  void onTargetHit() {
    createExplosion();
    targetBase.player.onHit(damage);

    if (targetBase.player.isSelf && targetBase.player.attackAlert.isReady) {
      Audio.get.playSound(Sound.EVA_BASE_UNDER_ATTACK);
    }
  }
}

abstract class ShotComponent extends PositionComponent {
  late Vector2 currentPosition;
  final PositionComponent sourceComponent;
  final PositionComponent targetComponent;
  final num damage;
  final bool targetDestroyed;
  late final double speed;
  late final double threshold;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  bool hit = false;

  ShotComponent({
    required super.position,
    required super.size,
    required this.sourceComponent,
    required this.targetComponent,
    required this.damage,
    required this.targetDestroyed,
    required Color color,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.shot.value,
       ) {
    fillPaint.color = color;
    currentPosition = sourceComponent.absolutePosition;
    speed = size.x * 80;
    threshold = 0.03 * speed;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (targetComponent.isRemoved) {
      _onHit();
    } else {
      final Vector2 direction =
          (targetComponent.absolutePosition - currentPosition).normalized();
      currentPosition += direction * speed * dt;

      final num distance = currentPosition.distanceTo(
        targetComponent.absolutePosition,
      );

      if (distance < threshold) {
        _onHit();
      }
    }
  }

  void _onHit() {
    if (!hit) {
      hit = true;
      onTargetHit();
    }
  }

  void onTargetHit();

  void createExplosion() {
    final ExplosionComponent explosionComponent = ExplosionComponent(
      position: targetComponent.absolutePosition,
      size: targetDestroyed ? targetComponent.size * 0.5 : size * 3,
    );
    match.add(explosionComponent);
    removeFromParent();
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
