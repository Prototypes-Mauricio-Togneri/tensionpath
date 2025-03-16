import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_launcher.dart';

class NodeLauncherComponent extends NodeComponent<NodeLauncher> {
  final Paint borderPaint = Paint();
  final Paint fillerPaint = Paint();

  NodeLauncherComponent({
    required super.node,
    required super.position,
    required super.size,
  }) {
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.color = Colors.white;

    fillerPaint.style = PaintingStyle.fill;
    fillerPaint.color = node.player.color.withAlpha(128);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), fillerPaint);
    canvas.drawRect(size.toRect(), borderPaint);
  }
}
