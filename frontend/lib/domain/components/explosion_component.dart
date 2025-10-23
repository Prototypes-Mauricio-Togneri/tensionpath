import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class ExplosionComponent extends PositionComponent {
  double percentage = 1;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.EXPLOSION,
  );

  ExplosionComponent({
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.explosion.value,
       );

  @override
  void update(double dt) {
    super.update(dt);

    percentage -= dt * 3;
    percentage = percentage.clamp(0, 1);

    fillPaint.color = fillPaint.color.withAlpha((percentage * 255).toInt());

    if (percentage == 0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      (size / 2).toOffset(),
      (size.x / 2) * percentage,
      fillPaint,
    );
  }
}
