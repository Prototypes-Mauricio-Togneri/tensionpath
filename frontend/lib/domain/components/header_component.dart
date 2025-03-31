import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
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
    final double centerIndicatorWidth = width * 0.1;
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
      position: Vector2(
        player.isSelf ? (width * 0.02) : (width * 0.98),
        size.y / 2,
      ),
      size: size.y * 0.5,
      color: Palette.PLAYER_NAME,
      anchor: player.isSelf ? Anchor.centerLeft : Anchor.centerRight,
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
    add(TimeIndicatorComponent(position: size / 2, size: size * 0.6));

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
      size: size.y,
      color: Palette.PLAYER_NAME,
    );
  }
}
