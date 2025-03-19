import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/entities/nodes/node_land.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeLandComponent extends NodeComponent<NodeLand> {
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Colors.white,
  );

  NodeLandComponent({
    required super.node,
    required super.position,
    required super.size,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawHexagon(size: size, borderPaint: borderPaint);
  }
}
