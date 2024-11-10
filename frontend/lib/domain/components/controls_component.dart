import 'dart:async';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
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
          priority: Priority.controls.value,
        );

  @override
  FutureOr onLoad() {
    backgroundPaint.style = PaintingStyle.fill;
    backgroundPaint.color = Palette.green;

    final double cardWidth = (size.x / 7) * 0.8;
    final double cardHeight = size.y * 0.8;

    final double horizontalGapSize = (size.x - (cardWidth * 7)) / 8;
    final double verticalGapSize = (size.y - cardHeight) / 2;

    add(CreditCounterComponent(
      player: player,
      position: Vector2(
        horizontalGapSize,
        verticalGapSize,
      ),
      size: Vector2(cardWidth, cardHeight),
    ));

    for (int i = 0; i < 6; i++) {
      final Vector2 position = Vector2(
        ((i + 1) * cardWidth) + ((i + 2) * horizontalGapSize),
        verticalGapSize,
      );

      add(UnitSelectorComponent(
        player: player,
        value: i + 1,
        position: position,
        size: Vector2(cardWidth, cardHeight),
      ));
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      backgroundPaint,
    );
  }
}

class CreditCounterComponent extends PositionComponent {
  final Player player;
  final Paint backgroundPaint = Paint();

  CreditCounterComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.topLeft,
          priority: Priority.controls.value,
        );

  @override
  FutureOr onLoad() {
    backgroundPaint.style = PaintingStyle.fill;
    backgroundPaint.color = Palette.orange;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      (size / 2).toOffset(),
      size.x / 2,
      backgroundPaint,
    );

    canvas.drawText(
      text: player.credits.floor().toString(),
      position: size / 2,
      size: size.y / 2,
      color: Palette.white,
    );
  }
}

class UnitSelectorComponent extends PositionComponent {
  final Player player;
  final int value;
  final Paint backgroundPaint = Paint();
  final Paint foregroundPaint = Paint();

  UnitSelectorComponent({
    required this.player,
    required this.value,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.topLeft,
          priority: Priority.controls.value,
        );

  @override
  FutureOr onLoad() {
    add(RectangleHitbox());

    backgroundPaint.style = PaintingStyle.fill;
    backgroundPaint.color = Palette.grey;

    foregroundPaint.style = PaintingStyle.fill;
    foregroundPaint.color = Palette.orange;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        size.x,
        size.y,
      ),
      backgroundPaint,
    );

    canvas.drawText(
      text: value.toString(),
      position: size / 2,
      size: size.y / 2,
      color: Palette.white,
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
          priority: Priority.controls.value,
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
