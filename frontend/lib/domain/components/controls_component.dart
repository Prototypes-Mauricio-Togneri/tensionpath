import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;
  final Paint backgroundPaint = Paint();

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.battlefield.value,
        );

  @override
  FutureOr onLoad() {
    backgroundPaint.style = PaintingStyle.fill;
    backgroundPaint.color = Palette.green;

    for (int i = 0; i < 10; i++) {
      final double bubbleSize = size.y / 1.4;
      final double gap = (size.x - (bubbleSize * 10)) / 11;
      final Vector2 position = Vector2(
        (i * (bubbleSize + gap)) + (bubbleSize / 2) + gap,
        size.y / 2,
      );

      add(CreditSelectorComponent(
        player: player,
        value: i + 1,
        position: position,
        size: Vector2(bubbleSize, bubbleSize),
      ));
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width * (player.hp / 100), height),
      backgroundPaint,
    );
  }
}

class CreditSelectorComponent extends PositionComponent with TapCallbacks {
  final Player player;
  final int value;
  final Paint chipPaint = Paint();
  final Paint fillingPaint = Paint();
  final Paint borderPaint = Paint();

  CreditSelectorComponent({
    required this.player,
    required this.value,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.battlefield.value,
        );

  @override
  FutureOr onLoad() {
    chipPaint.style = PaintingStyle.fill;
    chipPaint.color = Palette.grey;

    fillingPaint.style = PaintingStyle.fill;
    fillingPaint.color = Palette.orange;

    borderPaint.style = PaintingStyle.stroke;
    borderPaint.color = Palette.red;
    borderPaint.strokeWidth = size.y / 10;

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (player.credits >= value) {
      player.selectCredits(value);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final double radius = size.y / 2;
    final Offset center = (size / 2).toOffset();

    canvas.drawCircle(
      center,
      radius,
      chipPaint,
    );

    double fillValue = 1 - (value - player.credits);
    fillValue = fillValue.clamp(0, 1);

    canvas.drawCircle(
      center,
      radius * fillValue,
      fillingPaint,
    );

    canvas.drawText(
      text: value.toString(),
      position: center.toVector2(),
      size: radius,
      color: Palette.white,
    );

    if (player.creditsSelected == value) {
      canvas.drawCircle(
        center,
        radius,
        borderPaint,
      );
    }
  }
}
