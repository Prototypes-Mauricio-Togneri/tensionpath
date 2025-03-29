import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent<U extends Unit> extends SpriteComponent {
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
  FutureOr onLoad() async {
    sprite = await Sprite.load(unit.type.sprite);

    if (unit.player.isEnemy) {
      angle = pi;
    }

    add(
      HealthBarComponent(
        unit: unit,
        position: Vector2(width / 2, height * 1.08),
        size: Vector2(width * 0.7, size.y / 10),
      ),
    );

    return super.onLoad();
  }
}

class HealthBarComponent<U extends Unit> extends PositionComponent {
  final U unit;
  final Paint backgroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.UNIT_HEALTH_BACKGROUND,
  );
  final Paint foregroundHealthPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint borderHealthPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.UNIT_HEALTH_BORDERD,
  );

  HealthBarComponent({
    required this.unit,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value) {
    foregroundHealthPaint.color = unit.player.color;
    borderHealthPaint.strokeWidth = size.y / 20;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundHealthPaint);

    final double healthBar = width * (unit.health / unit.maxHealth);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, healthBar, height),
      foregroundHealthPaint,
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderHealthPaint);

    super.render(canvas);
  }
}
