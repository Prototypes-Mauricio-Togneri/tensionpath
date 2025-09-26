import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/movement_path_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_sprite.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends PositionComponent
    with DragCallbacks, HasVisibility {
  final String id;
  final UnitType type;
  final num nodeSizeRatio;
  final Player player;
  late HealthBarComponent healthBarComponent;
  late NodeComponent closestNodeComponent;
  late final MovementPathComponent movementOrderComponent;
  late final MovementPathComponent movementCurrentComponent;
  late final BattlefieldComponent battlefieldComponent;
  Vector2? endPosition;
  Vector2? targetPosition;
  NodeComponent? lockedNode;

  UnitComponent({
    required super.position,
    required super.size,
    required this.id,
    required this.type,
    required this.nodeSizeRatio,
    required this.player,
    required this.lockedNode,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.unit.value,
       );

  @override
  bool containsLocalPoint(Vector2 point) => Dimensions.pointInCircle(
    point: point,
    size: size,
  );

  bool belongsTo(Player other) => player.id == other.id;

  void refresh({
    required num health,
    required Vector2 newCurrentPosition,
    required Vector2? newTargetPosition,
    required NodeComponent? newLockedNode,
  }) {
    healthBarComponent.refresh(health);
    position = newCurrentPosition;
    targetPosition = newTargetPosition;
    lockedNode = newLockedNode;
  }

  bool get isRevealed => closestNodeComponent.isVisible;

  @override
  FutureOr onLoad() async {
    battlefieldComponent = parent as BattlefieldComponent;

    closestNodeComponent = match.getClosestNode(
      nodeTypes: NodeType.values,
      position: absolutePosition,
    );

    add(
      UnitImageComponent(
        position: size / 2,
        size: Vector2(size.x, size.x),
        unitType: type,
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

    movementOrderComponent = MovementPathComponent(
      color: Palette.PATH_MOVEMENT_ORDER.withAlpha(128),
      width: size.x / 30,
    );
    match.add(movementOrderComponent);

    movementCurrentComponent = MovementPathComponent(
      color: Palette.PATH_MOVEMENT_ORDER,
      width: size.x / 30,
    );
    match.add(movementCurrentComponent);

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (player.isSelf) {
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

      match.highlightTargetAt(endPosition!);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (player.isSelf) {
      final UnitComponent? unitComponent = match.getEnemyUnitAt(endPosition!);

      if ((unitComponent != null) && unitComponent.isRevealed) {
        match.onAttackUnit(
          attackerUnitComponent: this,
          defenderUnitComponent: unitComponent,
        );
      } else {
        final NodeComponent? nodeComponent = match.getNodeAt(
          nodeTypes: NodeType.canMove,
          position: endPosition!,
        );

        if ((nodeComponent != null) &&
            (nodeComponent != closestNodeComponent)) {
          match.onMoveUnit(
            unitComponent: this,
            nodeComponent: nodeComponent,
          );
        }
      }

      endPosition = null;
      movementOrderComponent.hide();
      match.unhighlightNodes();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (targetPosition != null) {
      if (player.isSelf) {
        movementCurrentComponent.show(
          start: absolutePosition,
          end: targetPosition! + battlefieldComponent.position,
        );
      }

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
    } else {
      movementCurrentComponent.hide();
    }

    closestNodeComponent = match.getClosestNode(
      nodeTypes: NodeType.values,
      position: absolutePosition,
    );

    isVisible = closestNodeComponent.isVisible || player.isSelf;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (endPosition != null) {
      movementOrderComponent.show(
        start: absolutePosition,
        end: endPosition!,
      );
    }
  }
}

class UnitImageComponent extends SpriteComponent {
  final UnitType unitType;
  final Player player;

  UnitImageComponent({
    required super.position,
    required super.size,
    required this.unitType,
    required this.player,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(unitSprite(unitType));
    scale = Vector2(0.5, 0.5);

    if (player.isPlayer1) {
      setBlueShade();
    } else if (player.isPlayer2) {
      setRedShade();
    }

    return super.onLoad();
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
    health = type.health.toDouble();
    maxHealth = type.health.toDouble();
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
