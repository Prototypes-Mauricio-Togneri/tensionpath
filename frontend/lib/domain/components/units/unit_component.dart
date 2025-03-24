import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent<U extends Unit> extends PositionComponent {
  final U unit;
  final Paint backgroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.grey,
  );
  final Paint foregroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.green,
  );

  UnitComponent({
    required this.unit,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  @override
  FutureOr onLoad() {
    if (unit.player.isEnemy) {
      angle = pi;
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(0, height + 10, width, 10),
      backgroundHealthPaint,
    );

    final double healthBar = width * (unit.health / unit.maxHealth);

    if (unit.player.isEnemy) {
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
