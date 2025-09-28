import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/formatter.dart';
import 'package:tensionpath/utils/palette.dart';

class HeaderComponent extends PositionComponent {
  final Player player1;
  final Player player2;

  HeaderComponent({
    required this.player1,
    required this.player2,
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.topLeft,
         priority: Priority.header.value,
       );

  @override
  FutureOr onLoad() {
    final double centerIndicatorWidth = width * 0.06;
    final double playerIndicatorWidth = (width - centerIndicatorWidth) / 2;

    add(
      PlayerIndicatorComponent(
        player: player1,
        position: Vector2(0, 0),
        size: Vector2(playerIndicatorWidth, height),
      ),
    );

    add(
      PlayerIndicatorComponent(
        player: player2,
        position: Vector2(playerIndicatorWidth + centerIndicatorWidth, 0),
        size: Vector2(playerIndicatorWidth, height),
      ),
    );

    add(
      CenterIndicatorComponent(
        position: Vector2(playerIndicatorWidth, 0),
        size: Vector2(centerIndicatorWidth, height),
      ),
    );

    return super.onLoad();
  }
}

class PlayerIndicatorComponent extends PositionComponent {
  final Player player;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.HEADER_INDICATOR_BACKGROUND,
  );
  final Paint fillPaint = Palette.paint(style: PaintingStyle.fill);

  PlayerIndicatorComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft) {
    fillPaint.color = player.color;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final double healthWidth =
        width * (player.baseHealth / player.baseMaxHealth);

    canvas.drawRect(
      Rect.fromLTWH(width - healthWidth, 0, healthWidth, height),
      fillPaint,
    );

    canvas.drawText(
      text: player.name.toUpperCase(),
      position: Vector2(
        player.isPlayer1 ? (width * 0.02) : (width * 0.98),
        size.y / 2,
      ),
      size: size.y * 0.5,
      color: Palette.HEADER_PLAYER_NAME,
      anchor: player.isPlayer1 ? Anchor.centerLeft : Anchor.centerRight,
    );
  }
}

class CenterIndicatorComponent extends PositionComponent with TapCallbacks {
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.HEADER_CENTER_BACKGROUND,
  );

  CenterIndicatorComponent({required super.position, required super.size})
    : super(anchor: Anchor.topLeft);

  @override
  bool onTapDown(TapDownEvent event) {
    game.matchState.onOpenMenu();
    return true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fillPaint);

    canvas.drawText(
      text: Formatter.hoursMinutes(match.timeElapsed),
      position: size / 2,
      size: size.y / 2,
      color: Palette.HEADER_PLAYER_NAME,
    );
  }
}
