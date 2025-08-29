import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class FogComponent extends PositionComponent {
  final Paint layerPaint = Palette.paint();
  final Paint fogPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.NODE_FOG,
  );
  final Paint clearPaint = Palette.paint(
    blendMode: BlendMode.clear,
  );

  FogComponent({
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.fog.value,
       );

  /*@override
  void render(Canvas canvas) {
    super.render(canvas);

    // Save a new layer so we can use BlendMode.clear
    canvas.saveLayer(null, layerPaint);

    // Draw the full-screen overlay
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fogPaint);

    // Cut out the "hole"
    final List<Offset> centers = [
      Offset(width / 2, height / 2),
      Offset(width / 4, height / 2),
      Offset(width * 0.75, height / 2),
      Offset(width * 0.6, height / 2),
    ];

    for (final Offset center in centers) {
      canvas.drawCircle(center, 100, clearPaint);
    }

    canvas.restore();
  }*/
}
