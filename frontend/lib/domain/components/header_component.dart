import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/palette.dart';

class HeaderComponent extends PositionComponent {
  final Player player1;
  final Player player2;

  HeaderComponent({
    required this.player1,
    required this.player2,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.header.value);

  @override
  FutureOr onLoad() {
    add(
      PlayerIndicatorComponent(
        player: player1,
        position: Vector2(0, 0),
        size: Vector2(width * 2 / 5, height),
      ),
    );

    add(
      PlayerIndicatorComponent(
        player: player2,
        position: Vector2(width * 3 / 5, 0),
        size: Vector2(width * 2 / 5, height),
      ),
    );

    add(
      CenterIndicatorComponent(
        position: Vector2(width * 2 / 5, 0),
        size: Vector2(width / 5, height),
      ),
    );

    return super.onLoad();
  }
}

class PlayerIndicatorComponent extends PositionComponent {
  final Player player;
  final Paint fillPaint = Palette.paint(style: PaintingStyle.fill);

  PlayerIndicatorComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.header.value) {
    fillPaint.color = player.color;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fillPaint);

    canvas.drawText(
      text: player.id.toUpperCase(),
      position: (size / 2) + Vector2(0, 0),
      size: size.y / 3,
      color: Palette.PLAYER_NAME,
      textAlign: TextAlign.left,
    );
  }
}

class CenterIndicatorComponent extends PositionComponent {
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.HEADER_BACKGROUND,
  );

  CenterIndicatorComponent({required super.position, required super.size})
    : super(anchor: Anchor.topLeft, priority: Priority.header.value);

  @override
  FutureOr onLoad() {
    add(
      TimeIndicatorComponent(
        position: Vector2(size.x / 2, size.y / 3),
        size: size / 1.5,
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fillPaint);
  }
}

class TimeIndicatorComponent extends PositionComponent {
  TimeIndicatorComponent({required super.position, required super.size})
    : super(anchor: Anchor.center, priority: Priority.header.value);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '3:45',
      position: size / 2,
      size: size.y / 2,
      color: Palette.PLAYER_NAME,
    );
  }
}

class FullScreenButtonComponent extends PositionComponent with TapCallbacks {
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Colors.white,
  );

  FullScreenButtonComponent({required super.position, required super.size})
    : super(anchor: Anchor.center, priority: Priority.header.value);

  @override
  void onTapUp(TapUpEvent event) => SetFullscreen.set();

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle((size / 2).toOffset(), size.x / 2, borderPaint);

    canvas.drawText(
      text: '⌞ ⌝',
      position: size / 2.2,
      size: size.y / 2,
      color: Palette.PLAYER_NAME,
    );
  }
}
