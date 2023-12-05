import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
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

    for (int i = 0; i < 10; i++) {
      canvas.drawCircle(
        Offset((i * 75) + 100, 75),
        50,
        BasicPalette.red.paint(),
      );

      canvas.drawText(
        text: player.credits.toInt().toString(),
        position: size / 2,
        size: 50,
        color: Palette.white,
      );
    }
  }
}
