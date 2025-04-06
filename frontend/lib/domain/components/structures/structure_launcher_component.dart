import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class StructureLauncherComponent extends StructureComponent<StructureLauncher> {
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.NODE_BORDER,
  );
  final Paint fillPaint = Palette.paint(style: PaintingStyle.fill);

  StructureLauncherComponent({
    required super.structure,
    required super.position,
    required super.size,
  }) {
    if (structure.hasPlayer) {
      fillPaint.color = structure.color!.withAlpha(128);
    }
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
