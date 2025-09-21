import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tensionpath/domain/components/movement_order_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends PositionComponent with DragCallbacks {
  final String id;
  final UnitType type;
  final num nodeSizeRatio;
  final Player player;
  late HealthBarComponent healthBarComponent;
  late NodeComponent closestNodeComponent;
  late final MovementOrderComponent movementOrderComponent;
  Vector2? endPosition;
  Vector2? targetPosition;

  UnitComponent({
    required super.position,
    required super.size,
    required this.id,
    required this.type,
    required this.nodeSizeRatio,
    required this.player,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.unit.value,
       );

  bool belongsTo(Player other) => player.id == other.id;

  void refresh({
    required num health,
    required Vector2 newCurrentPosition,
    required Vector2? newTargetPosition,
  }) {
    healthBarComponent.refresh(health);
    position = newCurrentPosition;
    targetPosition = newTargetPosition;
  }

  void moveTo(Vector2 position) {
    targetPosition = position;
  }

  @override
  FutureOr onLoad() async {
    closestNodeComponent = match.getClosestNode(
      nodeTypes: NodeType.values,
      position: absolutePosition,
    );

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

    movementOrderComponent = MovementOrderComponent();
    match.add(movementOrderComponent);

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (player.isSelf) {
      super.onDragStart(event);

      final Vector2 offsetFromCenter = event.localPosition - (size / 2);

      endPosition = Vector2(
        absolutePosition.x + offsetFromCenter.x,
        absolutePosition.y + offsetFromCenter.y,
      );
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (player.isSelf) {
      endPosition = Vector2(
        endPosition!.x + event.localDelta.x,
        endPosition!.y + event.localDelta.y,
      );

      match.highlightNodeAt(
        nodeTypes: NodeType.canMove,
        position: endPosition!,
      );
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (player.isSelf) {
      super.onDragEnd(event);

      final NodeComponent? nodeComponent = match.getNodeAt(
        nodeTypes: NodeType.canMove,
        position: endPosition!,
      );

      endPosition = null;
      movementOrderComponent.hide();
      match.unhighlightNodes();

      if ((nodeComponent != null) && (nodeComponent != closestNodeComponent)) {
        match.onMoveUnit(
          unitComponent: this,
          nodeComponent: nodeComponent,
        );
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (targetPosition != null) {
      final Vector2 direction = targetPosition! - position;
      final num distance = direction.length;
      final num speed = nodeSizeRatio * type.speed;

      if (distance < 1) {
        position = targetPosition!;
        targetPosition = null;
      } else {
        direction.normalize();
        position += direction * (speed * dt);
      }

      print(
        'Unit $id moved to $position at speed $speed. Remaining distance: $distance',
      );
    }

    closestNodeComponent = match.getClosestNode(
      nodeTypes: NodeType.values,
      position: absolutePosition,
    );
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

    if (endPosition != null) {
      movementOrderComponent.show(
        start: absolutePosition,
        end: endPosition!,
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
  late num health;
  late num maxHealth;

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

  void refresh(num newHealth) {
    health = newHealth;
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
