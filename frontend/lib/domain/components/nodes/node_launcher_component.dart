import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/entities/nodes/node_launcher.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeLauncherComponent extends NodeComponent<NodeLauncher> {
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.NODE_BORDER,
  );
  final Paint fillPaint = Palette.paint(style: PaintingStyle.fill);

  NodeLauncherComponent({
    required super.node,
    required super.position,
    required super.size,
  }) {
    fillPaint.color = node.playerColor!.withAlpha(128);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawHexagon(
      size: size,
      borderPaint: borderPaint,
      fillPaint: fillPaint,
    );

    super.render(canvas);
  }
}
