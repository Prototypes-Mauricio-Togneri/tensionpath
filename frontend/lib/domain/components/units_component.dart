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
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitsComponent extends PositionComponent
    with DragCallbacks
    implements Reconfigurable {
  final Player self;
  final Node node;
  final Paint outterPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint innerPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint movementPaint = Palette.paint(style: PaintingStyle.stroke);
  final Vector2 targetPosition = Vector2.zero();
  bool validTarget = false;

  UnitsComponent({
    required this.self,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  bool get _canDrag =>
      node.hasUnits && node.units!.player.isSelf && match.match.isSelfPlaying;

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
    if (node.hasUnits) {
      final Units units = node.units!;
      outterPaint.color = units.player.color.brighten(0.5);
      innerPaint.color = units.player.color;
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  @override
  void onDragStart(DragStartEvent event) {
    if (_canDrag) {
      super.onDragStart(event);

      targetPosition.setFrom(Vector2.copy(event.localPosition));
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_canDrag) {
      targetPosition.add(event.localDelta);

      final NodeComponent? nodeComponent = _getTargetNode();

      if (nodeComponent != null) {
        validTarget =
            node.location.isValidTarget(
              player: self,
              target: nodeComponent.node,
            ) &&
            (nodeComponent.node != node);
      } else {
        validTarget = false;
      }
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (_canDrag) {
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
    if (node.isRevealed && node.hasUnits) {
      final Units units = node.units!;

      canvas.drawUnitHexagon(
        position: size / 2,
        size: size,
        outterPaint: outterPaint,
        innerPaint: innerPaint,
        amount: units.amount,
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
    if (node.isRevealed && node.hasUnits && !targetPosition.isZero()) {
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
