import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/priority.dart';

class LaneComponent extends PositionComponent {
  final Player player;
  final Color color;
  final Paint backgroundPaint = Paint();

  LaneComponent({
    required this.player,
    required this.color,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.topLeft,
          priority: Priority.battlefield.value,
        );

  @override
  FutureOr onLoad() {
    backgroundPaint.style = PaintingStyle.fill;
    backgroundPaint.color = color.withAlpha(100);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      backgroundPaint,
    );
  }
}
