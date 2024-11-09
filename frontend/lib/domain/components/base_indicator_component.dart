import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/base.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';

class BaseIndicatorComponent extends PositionComponent {
  final Base base;
  final Paint backgroundPaint = Paint();
  final Paint foregroundPaint = Paint();

  BaseIndicatorComponent({
    required this.base,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.base.value,
        );

  @override
  FutureOr onLoad() {
    backgroundPaint.color = Colors.grey;
    foregroundPaint.color = base.color;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      backgroundPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width * (base.hp / 100), height),
      foregroundPaint,
    );

    canvas.drawText(
      text: base.player.id,
      position: size / 2,
      size: size.y / 2,
      color: Colors.white,
    );
  }
}
