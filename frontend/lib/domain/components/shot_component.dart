import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class ShotComponent extends PositionComponent {
  late Vector2 currentPosition;
  late final Vector2 endPosition;
  final UnitComponent attackerUnit;
  final UnitComponent targetUnit;
  final num damage;
  late final double speed;
  late final double threshold;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.NODE_HIGHLIGHTED,
  );

  ShotComponent({
    required super.position,
    required super.size,
    required this.attackerUnit,
    required this.targetUnit,
    required this.damage,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.shot.value,
       ) {
    fillPaint.color = attackerUnit.player.color;
    currentPosition = attackerUnit.absolutePosition;
    endPosition = targetUnit.absolutePosition;
    speed = size.x * 50;
    threshold = 5;
    print('ShotComponent speed: $speed');
  }

  @override
  void update(double dt) {
    super.update(dt);

    final Vector2 direction = (endPosition - currentPosition).normalized();
    currentPosition += direction * speed * dt;

    final num distance = currentPosition.distanceTo(endPosition);

    if (distance < threshold) {
      removeFromParent();
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
