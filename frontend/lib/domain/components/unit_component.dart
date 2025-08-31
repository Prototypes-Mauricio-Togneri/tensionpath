import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
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
        position: size / 2,
        size: size,
        type: type,
        player: player,
      ),
    );

    add(
      HealthBarComponent(
        position: size / 2,
        size: size,
        type: type,
        player: player,
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

  @override
  void render(Canvas canvas) {
    canvas.save();

    if (player.isPlayer2) {
      canvas.translate(size.x / 2, 0); // Move to the center of the sprite
      canvas.scale(-1, 1); // Flip horizontally
      canvas.translate(-size.x / 2, 0); // Move back to the original position
    }

    super.render(canvas);

    canvas.restore();
  }
}

class UnitImageComponent extends SpriteComponent {
  final UnitType type;
  final JsonPlayer player;

  UnitImageComponent({
    required super.position,
    required super.size,
    required this.type,
    required this.player,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(type.sprite);
    scale = Vector2(type.spriteScale, type.spriteScale);
    decorator.addLast(PaintDecorator.tint(player.color.darken(0.3)));

    return super.onLoad();
  }
}

class HealthBarComponent extends PositionComponent {
  final UnitType type;
  final JsonPlayer player;
  final Paint foregroundHealthPaint = Palette.paint(
    style: PaintingStyle.stroke,
  );
  final Paint borderHealthPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.UNIT_HEALTH_BORDER,
  );
  late double health;
  late double maxHealth;

  HealthBarComponent({
    required super.position,
    required super.size,
    required this.type,
    required this.player,
  }) : super(anchor: Anchor.center) {
    foregroundHealthPaint.color = player.color;
    borderHealthPaint.strokeWidth = size.y / 60;
    health = type.maxHealth.toDouble();
    maxHealth = type.maxHealth.toDouble();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final double radius = size.x / 2.5;
    final double thickness = size.y / 20;
    final double sweepDegrees = 360 * (health / maxHealth);
    final double borderThickness = thickness * 0.05;

    canvas.drawArc2(
      center: size / 2,
      radius: radius,
      thickness: thickness,
      sweepDegrees: sweepDegrees,
      paint: borderHealthPaint,
    );

    canvas.drawArc2(
      center: size / 2,
      radius: radius - borderThickness,
      thickness: thickness - (borderThickness * 2),
      sweepDegrees: sweepDegrees,
      paint: foregroundHealthPaint,
    );
  }
}
