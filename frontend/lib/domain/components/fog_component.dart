import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class FogComponent extends PositionComponent {
  final Paint paint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.NODE_FOG,
  );

  FogComponent({required super.position, required super.size})
    : super(anchor: Anchor.center, priority: Priority.fog.value);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
  }
}
