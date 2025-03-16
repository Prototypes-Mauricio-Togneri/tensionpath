import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_victory.dart';
import 'package:tensionpath/utils/painter.dart';

class NodeVictoryComponent extends NodeComponent<NodeVictory> {
  final Paint borderPaint = Painter.create(
    style: PaintingStyle.stroke,
    color: Colors.white,
  );
  final Paint fillerPaint = Painter.create(
    style: PaintingStyle.fill,
    color: Colors.transparent,
  );

  NodeVictoryComponent({
    required super.node,
    required super.position,
    required super.size,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), fillerPaint);
    canvas.drawRect(size.toRect(), borderPaint);
  }
}
