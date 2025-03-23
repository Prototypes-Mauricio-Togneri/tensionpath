import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/palette.dart';

class HeaderComponent extends PositionComponent {
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.green,
  );

  HeaderComponent({required super.position, required super.size})
    : super(anchor: Anchor.topLeft, priority: Priority.header.value);

  @override
  FutureOr onLoad() {
    add(
      FullScreenButtonComponent(
        position: Vector2(width - (height / 2), height / 2),
        size: Vector2(height * 0.7, height * 0.7),
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    canvas.drawText(
      text: '03:45',
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
