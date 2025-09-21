import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

// TODO(momo): can it be just a component instead of PositionComponent?
class MovementOrderComponent extends PositionComponent {
  final Paint targetPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 5,
    color: Palette.NODE_TARGET,
  );
  Vector2? startPosition;
  Vector2? endPosition;

  MovementOrderComponent({
    required super.position,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.node.value,
       );

  void show({
    required Vector2 start,
    required Vector2 end,
  }) {
    startPosition = start;
    endPosition = end;
  }

  void hide() {
    startPosition = null;
    endPosition = null;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if ((startPosition != null) && (endPosition != null)) {
      canvas.drawLine(
        startPosition!.toOffset(),
        endPosition!.toOffset(),
        targetPaint,
      );
    }
  }
}
