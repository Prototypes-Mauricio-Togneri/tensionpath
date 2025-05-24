import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/node_component.dart';
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

  bool get _canDrag => units.player.isSelf && match.match.hasActiveTurn;

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
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (_canDrag) {
      super.onDragEnd(event);

      final Vector2 direction = targetPosition! - (size / 2);

      // If board is flipped, invert the direction
      // direction = direction * -1;

      final NodeComponent? nodeComponent = match.getActionTargetAt(
        absolutePosition + direction,
      );

      if ((nodeComponent != null) && (nodeComponent.node != node)) {
        match.match.onMoveUnit(
          nodeOrigin: node,
          nodeTarget: nodeComponent.node,
        );
      }

      targetPosition = null;
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
