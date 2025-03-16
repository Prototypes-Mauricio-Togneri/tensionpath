import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';

class BattlefieldComponent extends PositionComponent {
  final Battlefield battlefield;
  final Paint backgroundPaint = Paint();

  BattlefieldComponent(this.battlefield)
    : super(
        position: Vector2(0, 0),
        size: Vector2(
          Constants.UI_BATTLEFIELD_WIDTH,
          Constants.UI_BATTLEFIELD_HEIGHT,
        ),
        anchor: Anchor.topLeft,
        priority: Priority.battlefield.value,
      );

  @override
  FutureOr onLoad() {
    backgroundPaint.color = const Color(0xff222222);

    for (final Node node in battlefield.nodes) {
      game.world.add(node.component);
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);
  }
}
