import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class ExplosionComponent extends PositionComponent {
  double radius = 0;
  late final double radiusLimit;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.green, // Palette.EXPLOSION,
  );

  ExplosionComponent({
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.explosion.value,
       ) {
    radiusLimit = size.x / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);

    radius += dt * radiusLimit * 3;

    if (radius >= radiusLimit) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      position.toOffset(),
      radius,
      fillPaint,
    );
  }
}
