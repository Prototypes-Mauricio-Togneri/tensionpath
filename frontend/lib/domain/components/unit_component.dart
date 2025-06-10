import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends PositionComponent
    with DragCallbacks, TapCallbacks
    implements Reconfigurable {
  final Player self;
  final Node node;
  final Paint outterPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint innerPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint movementPaint = Palette.paint(style: PaintingStyle.stroke);
  final Vector2 targetPosition = Vector2.zero();
  bool validTarget = false;

  UnitComponent({
    required this.self,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  bool get _canMove =>
      node.hasUnit && node.unit!.player.isSelf && match.match.isSelfPlaying;

  @override
  FutureOr onLoad() async {
    if (match.match.self.isPlayer2) {
      angle = pi;
    }

    reconfigure();

    match.add(
      MovementArrowComponent(
        node: node,
        movementPaint: movementPaint,
        targetPosition: targetPosition,
        position: absolutePosition,
        size: size,
      ),
    );

    return super.onLoad();
  }

  @override
  void reconfigure() {
    if (node.hasUnit) {
      final Unit unit = node.unit!;
      outterPaint.color = unit.player.color.darken(0.3);
      innerPaint.color = unit.player.color;
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  @override
  void onLongTapDown(TapDownEvent event) {
    if (_canMove) {
      match.match.onCancelUnitMovement(node);
    }
    event.continuePropagation = true;
  }

  @override
  void onTapDown(TapDownEvent event) {
    event.continuePropagation = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    event.continuePropagation = true;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    event.continuePropagation = true;
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (_canMove) {
      super.onDragStart(event);

      targetPosition.setFrom(Vector2.copy(event.localPosition));
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_canMove) {
      targetPosition.add(event.localDelta);

      final NodeComponent? nodeComponent = _getTargetNode();

      if (nodeComponent != null) {
        validTarget =
            match.match.validTarget(
              nodeOrigin: node,
              nodeTarget: nodeComponent.node,
            ) &&
            (nodeComponent.node != node);
      } else {
        validTarget = false;
      }
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (_canMove) {
      super.onDragEnd(event);

      final NodeComponent? nodeComponent = _getTargetNode();

      if ((nodeComponent != null) && (nodeComponent.node != node)) {
        match.match.onMoveUnit(
          nodeOrigin: node,
          nodeTarget: nodeComponent.node,
        );
      }

      targetPosition.setFrom(Vector2.zero());
    }
  }

  NodeComponent? _getTargetNode() {
    final Vector2 direction = targetPosition - (size / 2);

    return match.getNodeAtPosition(absolutePosition + direction);
  }

  @override
  void render(Canvas canvas) {
    if (node.isRevealed && node.hasUnit) {
      final Unit unit = node.unit!;

      canvas.drawUnitHexagon(
        position: size / 2,
        size: size,
        outterPaint: outterPaint,
        innerPaint: innerPaint,
        level: unit.level,
      );

      if (!targetPosition.isZero()) {
        movementPaint.color = validTarget
            ? Palette.UNIT_MOVEMENT_INDICATOR_VALID
            : Palette.UNIT_MOVEMENT_INDICATOR_INVALID;
      }
    }
  }
}

class MovementArrowComponent extends PositionComponent {
  final Node node;
  final Paint movementPaint;
  final Vector2 targetPosition;

  MovementArrowComponent({
    required this.node,
    required this.movementPaint,
    required this.targetPosition,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  @override
  void render(Canvas canvas) {
    if (node.isRevealed && node.hasUnit && !targetPosition.isZero()) {
      canvas.movementLine(
        origin: size / 2,
        target: targetPosition,
        radius: size.x,
        paint: movementPaint,
        moving: true,
      );
    }
  }
}
