import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;
  final Paint backgroundPaint = Palette.paint(style: PaintingStyle.fill);

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.controls.value) {
    backgroundPaint.color = player.color.darken(0.2);
  }

  @override
  FutureOr onLoad() {
    add(
      ResourceCounterComponent(
        player: player,
        position: Dimensions.controlsResourcesPosition(size),
        size: Dimensions.controlsResourcesSize(size),
      ),
    );

    add(
      PopcapCounterComponent(
        player: player,
        position: Dimensions.controlsPopcapPosition(size),
        size: Dimensions.controlsPopcapSize(size),
      ),
    );

    add(
      EndTurnComponent(
        player: player,
        position: Dimensions.controlsEndTurnPosition(size),
        size: Dimensions.controlsEndTurnSize(size),
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);
  }
}

class ResourceCounterComponent extends PositionComponent {
  final Player player;

  ResourceCounterComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.centerLeft);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '\$ ${player.resources.floor().toString()}',
      position: Vector2(size.x * 0.07, size.y / 2),
      size: size.x / 5,
      color: Palette.CONTROLS_COST_FOREGROUND,
      anchor: Anchor.centerLeft,
    );
  }
}

class PopcapCounterComponent extends PositionComponent
    implements Reconfigurable {
  final Player player;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_BACKGROUND,
  );
  final Paint foregroundPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint placeholderPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_PLACEHOLDER,
  );
  int popcap = 0;
  int counter = 0;

  PopcapCounterComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    popcap = match.match.config.popcap;
    foregroundPaint.color = player.color;
    reconfigure();

    return super.onLoad();
  }

  @override
  void reconfigure() {
    counter = match.match.populationOf(player);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final double gap = size.x / 80;
    final double blockSize = (width - gap * (popcap + 1)) / popcap;

    for (int i = 0; i < counter; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          gap + (blockSize + gap) * i,
          gap,
          blockSize,
          height - (gap * 2),
        ),
        foregroundPaint,
      );
    }

    for (int i = counter; i < popcap; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          gap + (blockSize + gap) * i,
          gap,
          blockSize,
          height - (gap * 2),
        ),
        placeholderPaint,
      );
    }
  }
}

class EndTurnComponent extends PositionComponent with TapCallbacks {
  final Player player;
  final Paint backgroundPaintEnabled = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_END_TURN_BACKGROUND_ENABLED.darken(0.3),
  );
  final Paint backgroundPaintDisabled = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_END_TURN_BACKGROUND_DISABLED.darken(0.3),
  );

  EndTurnComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  void onTapUp(TapUpEvent event) => match.match.onEndTurn();

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (match.match.isSelfPlaying) {
      canvas.drawRect(size.toRect(), backgroundPaintEnabled);
      canvas.drawText(
        text: 'END TURN',
        position: Vector2(size.x / 2, size.y / 2),
        size: size.x / 8,
        color: Palette.CONTROLS_COST_FOREGROUND,
      );
    } else {
      canvas.drawRect(size.toRect(), backgroundPaintDisabled);
      canvas.drawText(
        text: 'WAITING',
        position: Vector2(size.x / 2, size.y / 2),
        size: size.x / 8,
        color: Palette.CONTROLS_COST_FOREGROUND,
      );
    }
  }
}
