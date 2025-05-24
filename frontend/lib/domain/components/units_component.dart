import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitsComponent extends PositionComponent with DragCallbacks {
  final Units units;
  final Node node;
  final Paint paintOutter = Palette.paint(style: PaintingStyle.fill);
  final Paint paintInner = Palette.paint(style: PaintingStyle.fill);
  Vector2? targetPosition;

  UnitsComponent({
    required this.units,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value) {
    paintOutter.color = units.player.color.brighten(0.5);
    paintInner.color = units.player.color;
  }

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  @override
  void onDragStart(DragStartEvent event) {
    if (units.player.isSelf && match.match.hasActiveTurn) {
      super.onDragStart(event);

      targetPosition = Vector2.copy(event.localPosition);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (units.player.isSelf && match.match.hasActiveTurn) {
      targetPosition!.add(event.localDelta);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (units.player.isSelf && match.match.hasActiveTurn) {
      super.onDragEnd(event);
      targetPosition = null;

      /*final NodeComponent? nodeComponent = match.getActionTargetAt(
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
          position = targetPosition;
        } else if (nodeComponent.node.isAttackBaseTarget(unit)) {
          match.match.onAttackBase(unit: unit, node: nodeComponent.node);
          position = targetPosition;
        } else {
          position = targetPosition;
        }
      } else {
        position = targetPosition;
      }*/
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle((size / 2).toOffset(), size.x / 3, paintOutter);
    canvas.drawCircle((size / 2).toOffset(), size.x / 3.5, paintInner);

    canvas.drawText(
      text: units.amount.toString(),
      color: Palette.UNIT_INDICATOR,
      position: size / 2,
      size: size.x / 4,
    );

    if (targetPosition != null) {
      canvas.drawLine(
        (size / 2).toOffset(),
        targetPosition!.toOffset(),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2.0,
      );
    }
  }
}
