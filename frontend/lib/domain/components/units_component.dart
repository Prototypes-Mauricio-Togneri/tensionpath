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
  bool validTarget = false;

  UnitsComponent({
    required this.units,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value) {
    paintOutter.color = units.player.color.brighten(0.5);
    paintInner.color = units.player.color;
  }

  bool get _canDrag => units.player.isSelf && match.match.isSelfPlaying;

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
    canvas.drawUnitCircle(
      position: size / 2,
      size: size,
      paintOutter: paintOutter,
      paintInner: paintInner,
      amount: units.amount,
    );

    if (targetPosition != null) {
      _lineTo(
        canvas: canvas,
        target: targetPosition!,
        color: validTarget
            ? Palette.UNIT_MOVEMENT_INDICATOR_VALID
            : Palette.UNIT_MOVEMENT_INDICATOR_INVALID,
      );
    }
  }

  void _lineTo({
    required Canvas canvas,
    required Vector2 target,
    required Color color,
  }) {
    final Vector2 origin = _moveTowards(
      origin: size / 2,
      target: target,
      distance: size.x / 3,
    );

    canvas.drawLine(
      origin.toOffset(),
      target.toOffset(),
      Paint()
        ..color = color
        ..strokeWidth = size.x / 20,
    );
  }

  Vector2 _moveTowards({
    required Vector2 origin,
    required Vector2 target,
    required double distance,
  }) {
    final Vector2 direction = target - origin;

    if (direction.length == 0) {
      return origin;
    } else {
      return origin + direction.normalized() * distance;
    }
  }
}
