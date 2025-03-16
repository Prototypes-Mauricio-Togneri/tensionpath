import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';

class NodeComponent extends PositionComponent {
  final Node node;
  final Paint borderPaint = Paint();

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.node.value) {
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.color = const Color(0xffffffff);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), borderPaint);
  }
}
