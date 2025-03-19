import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/entities/nodes/node_victory.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeVictoryComponent extends NodeComponent<NodeVictory> {
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Colors.white,
  );
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.yellow,
  );

  NodeVictoryComponent({
    required super.node,
    required super.position,
    required super.size,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawHexagon(
      size: size,
      borderPaint: borderPaint,
      fillPaint: fillPaint,
    );
  }
}
