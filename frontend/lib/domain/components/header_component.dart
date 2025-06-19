import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/formatter.dart';
import 'package:tensionpath/utils/palette.dart';

class HeaderComponent extends PositionComponent with TapCallbacks {
  final Player player1;
  final Player player2;
  final Config config;

  HeaderComponent({
    required this.player1,
    required this.player2,
    required this.config,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.header.value);

  @override
  void onTapUp(TapUpEvent event) => game.onMenu();

  @override
  FutureOr onLoad() {
    final double centerIndicatorWidth = width * 0.15;
    final double playerIndicatorWidth = (width - centerIndicatorWidth) / 2;

    add(
      PlayerIndicatorComponent(
        player: player1,
        config: config,
        position: Vector2(0, 0),
        size: Vector2(playerIndicatorWidth, height),
      ),
    );

    add(
      PlayerIndicatorComponent(
        player: player2,
        config: config,
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
  final Config config;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.HEADER_INDICATOR_BACKGROUND,
  );
  final Paint fillPaint = Palette.paint(style: PaintingStyle.fill);

  PlayerIndicatorComponent({
    required this.player,
    required this.config,
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
        width * (player.baseHealth / config.baseMaxHealth);

    if (player.isPlayer1) {
      canvas.drawRect(
        Rect.fromLTWH(width - healthWidth, 0, healthWidth, height),
        fillPaint,
      );
    } else {
      canvas.drawRect(Rect.fromLTWH(0, 0, healthWidth, height), fillPaint);
    }

    canvas.drawText(
      text: player.name,
      position: Vector2(
        player.isPlayer1 ? (width * 0.05) : (width * 0.95),
        size.y / 2,
      ),
      size: size.y * 0.4,
      color: Palette.HEADER_PLAYER_NAME,
      anchor: player.isPlayer1 ? Anchor.centerLeft : Anchor.centerRight,
    );
  }
}

class CenterIndicatorComponent extends PositionComponent {
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.HEADER_CENTER_BACKGROUND,
  );

  CenterIndicatorComponent({required super.position, required super.size})
    : super(anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fillPaint);

    canvas.drawText(
      text: 'TURN: ${match.match.turn.turn}',
      position: Vector2(size.x / 2, size.y * 0.3),
      size: size.y / 4,
      color: Palette.HEADER_PLAYER_NAME,
    );

    canvas.drawText(
      text: Formatter.duration(match.match.timeElapsed),
      position: Vector2(size.x / 2, size.y * 0.7),
      size: size.y / 4,
      color: Palette.HEADER_PLAYER_NAME,
    );
  }
}
