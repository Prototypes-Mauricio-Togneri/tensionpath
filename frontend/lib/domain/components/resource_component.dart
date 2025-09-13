import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class ResourceComponent extends PositionComponent {
  final Paint foregroundPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint borderPaint = Palette.paint(style: PaintingStyle.fill);
  late final double borderWidth;

  ResourceComponent({
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       ) {
    borderWidth = size.x * 0.05;
    foregroundPaint.color = Palette.RESOURCES;
    borderPaint.color = Palette.RESOURCES.darken(0.3);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawStructure(
      center: position,
      width: width,
      height: height,
      borderWidth: borderWidth,
      foregroundPaint: foregroundPaint,
      borderPaint: borderPaint,
    );
  }
}
