import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/extensions/paint_extension.dart';
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
      EndTurnComponent(
        player: player,
        position: Dimensions.controlsEndTurnPosition(size),
        size: size,
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
      size: size.x / 7,
      color: Palette.CONTROLS_COST_FOREGROUND,
      anchor: Anchor.centerLeft,
    );
  }
}

class EndTurnComponent extends PositionComponent with TapCallbacks {
  final Player player;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_END_TURN_BACKGROUND,
  );

  @override
  void onTapUp(TapUpEvent event) {
    if (match.match.isSelfTurn) {
      match.match.onEndTurn();
    } else if (Environment.get.isDebug) {
      match.match.onOpponentEndTurn();
    }
  }

  EndTurnComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint fill =
        match.match.isSelfTurn
            ? backgroundPaint
            : backgroundPaint.grayscale(0.2);

    canvas.drawRect(size.toRect(), fill);

    Color activeTextColor = Palette.CONTROLS_COST_FOREGROUND;

    if (match.match.isSelfTurn) {
      activeTextColor = activeTextColor.withAlpha(255);
    } else {
      activeTextColor = activeTextColor.withAlpha(128);
    }

    if (match.match.isSelfTurn) {
      canvas.drawText(
        text: '${match.match.accumulatedResourcesInTurn.floor()}🛢️',
        position: Vector2(size.x / 2, size.y / 3.5),
        size: size.x / 6,
        color: activeTextColor,
      );

      canvas.drawText(
        text: 'END TURN',
        position: Vector2(size.x / 2, size.y * 3 / 4),
        size: size.x / 7,
        color: activeTextColor,
      );
    } else {
      canvas.drawText(
        text: "WAITING FOR\nOPPONENT'S\nTURN",
        position: Vector2(size.x / 2, size.y / 2),
        size: size.x / 10,
        color: activeTextColor,
      );
    }
  }
}
