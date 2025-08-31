import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/json_location.dart';
import 'package:tensionpath/domain/json/json_unit.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends PositionComponent with DragCallbacks {
  final String id;
  final UnitType type;
  final Player player;
  late HealthBarComponent healthBarComponent;
  Vector2? targetPosition;
  Vector2? destinationPosition;

  UnitComponent({
    required super.position,
    required super.size,
    required this.id,
    required this.type,
    required this.player,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.unit.value,
       );

  void refresh(JsonUnit unit) => healthBarComponent.refresh(unit);

  void moveTo({
    required JsonLocation location,
    required Vector2 position,
  }) {
    destinationPosition = position;
  }

  @override
  FutureOr onLoad() async {
    add(
      UnitImageComponent(
        position: size / 2,
        size: Vector2(size.x, size.x),
        type: type,
        player: player,
      ),
    );

    healthBarComponent = HealthBarComponent(
      position: size / 2,
      size: size,
      type: type,
      player: player,
    );

    add(healthBarComponent);

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (player.isSelf) {
      super.onDragStart(event);

      final Vector2 offsetFromCenter = event.localPosition - (size / 2);

      targetPosition = Vector2(
        absolutePosition.x + offsetFromCenter.x,
        absolutePosition.y + offsetFromCenter.y,
      );
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (player.isSelf) {
      targetPosition = Vector2(
        targetPosition!.x + event.localDelta.x,
        targetPosition!.y + event.localDelta.y,
      );

      match.highlightNodeAt(
        nodeTypes: [NodeType.empty, NodeType.resources, NodeType.pad],
        position: targetPosition!,
      );
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (player.isSelf) {
      super.onDragEnd(event);

      final NodeComponent? nodeComponent = match.getNodeAt(
        nodeTypes: [NodeType.empty, NodeType.resources, NodeType.pad],
        position: targetPosition!,
      );

      targetPosition = null;
      match.hideTarget();
      match.unhighlightNodes();

      if (nodeComponent != null) {
        match.onMoveUnit(
          unitComponent: this,
          nodeComponent: nodeComponent,
        );
      }

      /*if (nodeComponent != null) {
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
  void update(double dt) {
    super.update(dt);

    if (destinationPosition != null) {
      final Vector2 direction = destinationPosition! - absolutePosition;
      final double distance = direction.length;
      final double speed = size.x * type.speed;

      if (distance < 1) {
        position = destinationPosition!;
        destinationPosition = null;
      } else {
        direction.normalize();
        position += direction * (speed * dt);
      }
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

    if (targetPosition != null) {
      match.showTarget(
        start: absolutePosition,
        end: targetPosition!,
      );
    }
  }
}

class UnitImageComponent extends SpriteComponent {
  final UnitType type;
  final Player player;

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
  final Player player;
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

  void refresh(JsonUnit unit) {
    health = unit.health;
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
