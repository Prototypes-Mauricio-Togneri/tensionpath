import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/nodes/node_capturable_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_chest.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
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

    canvas.drawText(
      text: node.creditsAccumulated.toString(),
      position: size / 2,
      size: 70,
      color: Palette.yellow,
    );
  }
}
