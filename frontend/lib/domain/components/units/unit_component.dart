import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent<U extends Unit> extends PositionComponent
    with DragCallbacks {
  final U unit;
  final Node node;
  final Vector2 initialPosition = Vector2(0, 0);

  UnitComponent({
    required this.unit,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  @override
  FutureOr onLoad() async {
    add(UnitImageComponent(unit: unit, position: size / 2, size: size));

    add(
      HealthBarComponent(
        unit: unit,
        position: Vector2(width / 2, height * 0.1),
        size: Vector2(width * 0.7, size.y / 10),
      ),
    );

    add(
      RemainingMovementComponent(
        unit: unit,
        position: Vector2(width * 0.3, height * 0.9),
        size: Vector2(width * 0.3, size.y / 5),
      ),
    );

    add(
      RemainingAttacksComponent(
        unit: unit,
        position: Vector2(width * 0.7, height * 0.9),
        size: Vector2(width * 0.3, size.y / 5),
      ),
    );

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (unit.player.isSelf && match.match.isSelfTurn) {
      super.onDragStart(event);

      initialPosition.setFrom(position);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (unit.player.isSelf && match.match.isSelfTurn) {
      position += event.localDelta;
      match.highlightNode(
        match.getActionTargetAt(position: absolutePosition, unit: unit),
      );
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (unit.player.isSelf && match.match.isSelfTurn) {
      super.onDragEnd(event);

      final NodeComponent? nodeComponent = match.getActionTargetAt(
        position: absolutePosition,
        unit: unit,
      );

      if (nodeComponent != null) {
        if (nodeComponent.node.isMovementTarget(unit)) {
          match.match.onMoveUnit(
            unit: unit,
            nodeOrigin: node,
            nodeTarget: nodeComponent.node,
          );
        } else if (nodeComponent.node.isAttackUnitTarget(unit)) {
          match.match.onAttackUnit(
            unitAttacker: unit,
            unitDefender: nodeComponent.node.unit!,
          );
          position = initialPosition;
        } else if (nodeComponent.node.isAttackBaseTarget(unit)) {
          match.match.onAttackBase(unit: unit, node: nodeComponent.node);
          position = initialPosition;
        } else {
          position = initialPosition;
        }
      } else {
        position = initialPosition;
      }
    }
  }

  /*@override
  void render(Canvas canvas) {
    canvas.save();

    if (unit.player.isPlayer2) {
      canvas.translate(size.x / 2, 0); // Move to the center of the sprite
      canvas.scale(-1, 1); // Flip horizontally
      canvas.translate(-size.x / 2, 0); // Move back to the original position
    }

    super.render(canvas);

    canvas.restore();
  }*/
}

class UnitImageComponent<U extends Unit> extends SpriteComponent {
  final U unit;

  UnitImageComponent({
    required this.unit,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(unit.sprite);
    scale = Vector2(unit.type.spriteScale, unit.type.spriteScale);

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
    color: Palette.UNIT_HEALTH_BORDER,
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

class RemainingMovementComponent<U extends Unit> extends PositionComponent {
  final U unit;
  final Paint backgroundIndicatorPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.UNIT_INDICATOR_BACKGROUND,
  );
  final Paint foregroundIndicatorPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.UNIT_INDICATOR_FOREGROUND,
  );

  RemainingMovementComponent({
    required this.unit,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (unit.belongsTo(match.match.self) && match.match.isSelfTurn) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height),
        backgroundIndicatorPaint,
      );
      canvas.drawText(
        text: '↷ ${unit.remainingMoves}',
        position: Vector2(width / 2, height * 0.5),
        size: size.y * 0.7,
        color: Palette.UNIT_INDICATOR_FOREGROUND,
      );
    }
  }
}

class RemainingAttacksComponent<U extends Unit> extends PositionComponent {
  final U unit;
  final Paint backgroundIndicatorPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.UNIT_INDICATOR_BACKGROUND,
  );
  final Paint foregroundIndicatorPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.UNIT_INDICATOR_FOREGROUND,
  );

  RemainingAttacksComponent({
    required this.unit,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (unit.belongsTo(match.match.self) && match.match.isSelfTurn) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, width, height),
        backgroundIndicatorPaint,
      );
      canvas.drawText(
        text: '⚔️ ${unit.remainingAttacks}',
        position: Vector2(width / 2, height * 0.4),
        size: size.y * 0.7,
        color: Palette.UNIT_INDICATOR_FOREGROUND,
      );
    }
  }
}
