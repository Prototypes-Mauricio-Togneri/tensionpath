import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/game/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_chest.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeChestComponent extends NodeCapturableComponent<NodeChest>
    with TapCallbacks {
  NodeChestComponent({
    required super.node,
    required super.size,
  });

  @override
  void onTapUp(TapUpEvent event) {
    if (node.hasOwner && node.hasCreditsAccumulated) {
      node.onAcquired();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    const textStyle = TextStyle(
      color: Palette.yellow,
      fontSize: 70,
    );
    final textSpan = TextSpan(
      text: node.creditsAccumulated.toString(),
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 100,
    );
    final offset = (size / 2).toOffset();
    textPainter.paint(canvas, Offset(offset.dx - 20, offset.dy - 40));
  }
}
