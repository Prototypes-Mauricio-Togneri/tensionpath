import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.topLeft,
          priority: Priority.battlefield.value,
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      BasicPalette.green.paint(),
    );

    const double bubbleSize = 80;
    final double gap = (size.x - (bubbleSize * 10)) / 11;

    for (int i = 0; i < 10; i++) {
      final Offset center = Offset(
        (i * (bubbleSize + gap)) + (bubbleSize / 2) + gap,
        size.y / 2,
      );

      canvas.drawCircle(
        center,
        bubbleSize / 2,
        BasicPalette.red.paint(),
      );

      canvas.drawText(
        text: (i + 1).toString(),
        position: center.toVector2(),
        size: 50,
        color: Palette.white,
      );
    }
  }
}
