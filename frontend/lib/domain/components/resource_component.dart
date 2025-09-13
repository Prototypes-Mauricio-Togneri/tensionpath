import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class ResourceComponent extends PositionComponent {
  final Paint foregroundPaint = Palette.paint(
    color: Palette.RESOURCES_FOREGROUND,
    style: PaintingStyle.fill,
  );
  final Paint borderPaint = Palette.paint(
    color: Palette.RESOURCES_BORDER,
    style: PaintingStyle.fill,
  );
  late final double borderWidth;

  ResourceComponent({
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       ) {
    borderWidth = size.x * 0.05;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      foregroundPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        borderWidth,
        borderWidth,
        width - borderWidth * 2,
        height - borderWidth * 2,
      ),
      borderPaint,
    );
  }
}
