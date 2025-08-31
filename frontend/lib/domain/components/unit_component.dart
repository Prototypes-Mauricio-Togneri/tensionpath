import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends PositionComponent with DragCallbacks {
  final UnitType type;
  final JsonPlayer player;
  Vector2 targetPosition = Vector2(0, 0);

  UnitComponent({
    required super.position,
    required super.size,
    required this.type,
    required this.player,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.unit.value,
       );

  @override
  FutureOr onLoad() async {
    add(
      UnitImageComponent(
        type: type,
        position: size / 2,
        size: size,
      ),
    );

    add(
      HealthBarComponent(
        type: type,
        player: player,
        position: Vector2(width / 2, height * 0.1),
        size: Vector2(width * 0.7, size.y / 10),
      ),
    );

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (player.isSelf) {
      super.onDragStart(event);

      targetPosition.setFrom(position);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (player.isSelf) {
      targetPosition += event.localDelta;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (player.isSelf) {
      super.onDragEnd(event);

      /*final NodeComponent? nodeComponent = match.getActionTargetAt(
        position: absolutePosition,
        unit: unit,
      );

      if (nodeComponent != null) {
        if (nodeComponent.node.isMovementTarget(unit)) {
          /*match.match.onMoveUnit(
            unit: unit,
            nodeOrigin: node,
            nodeTarget: nodeComponent.node,
          );*/
        } else if (nodeComponent.node.isAttackUnitTarget(unit)) {
          /*match.match.onAttackUnit(
            unitAttacker: unit,
            unitDefender: nodeComponent.node.unit!,
          );*/
          position = initialPosition;
        } else if (nodeComponent.node.isAttackBaseTarget(unit)) {
          //match.match.onAttackBase(unit: unit, node: nodeComponent.node);
          position = initialPosition;
        } else {
          position = initialPosition;
        }
      } else {
        position = initialPosition;
      }*/
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

class UnitImageComponent extends SpriteComponent {
  final UnitType type;

  UnitImageComponent({
    required this.type,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(type.sprite);
    scale = Vector2(type.spriteScale, type.spriteScale);

    return super.onLoad();
  }
}

class HealthBarComponent extends PositionComponent {
  final UnitType type;
  final JsonPlayer player;
  final Paint backgroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.UNIT_HEALTH_BACKGROUND,
  );
  final Paint foregroundHealthPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint borderHealthPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.UNIT_HEALTH_BORDER,
  );
  double health = 100;
  double maxHealth = 100;

  HealthBarComponent({
    required this.type,
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center) {
    foregroundHealthPaint.color = player.color;
    borderHealthPaint.strokeWidth = size.y / 20;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundHealthPaint);

    final double healthBar = width * (health / maxHealth);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, healthBar, height),
      foregroundHealthPaint,
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderHealthPaint);
  }
}
