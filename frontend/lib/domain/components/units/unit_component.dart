import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent<U extends Unit> extends SpriteComponent with DragCallbacks {
  final U unit;
  final Node node;
  final Paint backgroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.grey,
  );
  final Paint foregroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.green,
  );
  Vector2 initialPosition = Vector2(0, 0);
  bool dragging = false;

  UnitComponent({
    required this.unit,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(unit.type.sprite);

    if (unit.player.isOpponent) {
      angle = pi;
    }

    add(
      HealthBarComponent(
        unit: unit,
        position: Vector2(width / 2, height * 0.1),
        size: Vector2(width * 0.7, size.y / 10),
      ),
    );

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    initialPosition.setFrom(position);
    dragging = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
    match.highlightNode(
      match.getActionTargetAt(position: absolutePosition, origin: node),
    );
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    /*final NodeComponent? nodeComponent = match.getLauncherAt(absolutePosition);

    if (nodeComponent != null) {
      match.onDeployUnit(nodeComponent: nodeComponent, unitType: unitType);
    }*/

    position = initialPosition;
    dragging = false;
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
  }) : super(anchor: Anchor.center) {
    foregroundHealthPaint.color = unit.player.color;
    borderHealthPaint.strokeWidth = size.y / 20;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundHealthPaint);

    final double healthBar = width * (unit.health / unit.maxHealth);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, healthBar, height),
      foregroundHealthPaint,
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderHealthPaint);
  }
}
