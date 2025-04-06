import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/structures/structure_platform.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class StructurePlatformComponent extends StructureComponent<StructurePlatform> {
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.NODE_BORDER,
  );
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.NODE_PLATFORM,
  );

  StructurePlatformComponent({
    required super.structure,
    required super.position,
    required super.size,
  });

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
