import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class ShotComponent extends PositionComponent {
  late double radius;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.EXPLOSION,
  );

  ShotComponent({
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.shot.value,
       ) {
    radius = size.x / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);

    radius -= dt;
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
