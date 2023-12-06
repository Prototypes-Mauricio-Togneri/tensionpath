import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;
  final Paint backgroundPaint = Paint();
  final Paint chipPaint = Paint();
  final Paint fillingPaint = Paint();

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
    required super.angle,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.battlefield.value,
        );

  @override
  FutureOr onLoad() {
    backgroundPaint.style = PaintingStyle.fill;
    backgroundPaint.color = Palette.green;

    chipPaint.style = PaintingStyle.fill;
    chipPaint.color = Palette.grey;

    fillingPaint.style = PaintingStyle.fill;
    fillingPaint.color = Palette.orange;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      backgroundPaint,
    );

    final double bubbleSize = size.y / 1.4;
    final double gap = (size.x - (bubbleSize * 10)) / 11;

    for (int i = 0; i < 10; i++) {
      final Offset center = Offset(
        (i * (bubbleSize + gap)) + (bubbleSize / 2) + gap,
        size.y / 2,
      );

      canvas.drawCircle(
        center,
        bubbleSize / 2,
        chipPaint,
      );

      double fillValue = 0;

      if (player.credits < i) {
        fillValue = 0;
      } else if (player.credits > (i + 1)) {
        fillValue = 1;
      } else {
        fillValue = player.credits - i;
      }

      canvas.drawCircle(
        center,
        (bubbleSize / 2) * fillValue,
        fillingPaint,
      );

      canvas.drawText(
        text: (i + 1).toString(),
        position: center.toVector2(),
        size: bubbleSize / 2,
        color: Palette.white,
      );
    }
  }
}
