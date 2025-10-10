import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class DeploymentIndicatorComponent extends PositionComponent {
  final Location location;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.NODE_HIGHLIGHTED.withAlpha(128),
  );
  double filled = 0;

  static const int TIMEOUT = 3; // in seconds

  DeploymentIndicatorComponent({
    required super.position,
    required super.size,
    required this.location,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.node.value,
       );

  @override
  void update(double dt) {
    super.update(dt);

    filled += dt / TIMEOUT;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Offset center = (size / 2).toOffset();
    final double radius = size.x / 2;
    final double sweepAngle = filled.clamp(0.0, 1.0) * 2 * pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      true,
      fillPaint,
    );
  }
}
