import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/game/nodes/node_base_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeChestComponent extends NodeBaseComponent with CollisionCallbacks {
  NodeChestComponent({
    required super.node,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    add(circleHitbox);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    node.update(dt);

    super.update(dt);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) && node.hasCommandPointsAccumulated) {
      node.onChestAcquired(other.owner);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    const textStyle = TextStyle(
      color: Palette.yellow,
      fontSize: 70,
    );
    final textSpan = TextSpan(
      text: node.commandPointsAccumulated.toString(),
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
