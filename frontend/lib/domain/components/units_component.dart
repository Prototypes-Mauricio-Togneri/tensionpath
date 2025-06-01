import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitsComponent extends PositionComponent
    with DragCallbacks
    implements Reconfigurable {
  final Node node;
  final Paint outterPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint innerPaint = Palette.paint(style: PaintingStyle.fill);
  Vector2? targetPosition;
  bool validTarget = false;

  UnitsComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  bool get _canDrag =>
      node.hasUnits && node.units!.player.isSelf && match.match.isSelfPlaying;

  @override
  FutureOr onLoad() async {
    reconfigure();

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

      targetPosition = Vector2.copy(event.localPosition);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_canDrag) {
      targetPosition!.add(event.localDelta);

      final NodeComponent? nodeComponent = _getTargetNode();

      if (nodeComponent != null) {
        validTarget =
            node.location.isValidTarget(nodeComponent.node) &&
            (nodeComponent.node != node);
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

      targetPosition = null;
    }
  }

  NodeComponent? _getTargetNode() {
    final Vector2 direction = targetPosition! - (size / 2);

    // If board is flipped, invert the direction
    // direction = direction * -1;

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

      if (targetPosition != null) {
        canvas.movementLine(
          origin: size / 2,
          target: targetPosition!,
          size: size,
          color: validTarget
              ? Palette.UNIT_MOVEMENT_INDICATOR_VALID
              : Palette.UNIT_MOVEMENT_INDICATOR_INVALID,
        );
      }
    }
  }
}
