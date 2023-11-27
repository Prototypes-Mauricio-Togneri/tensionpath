import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/label_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent extends PositionComponent with CollisionCallbacks {
  final GameState state;
  final Node node;
  Paint paint = Paint();

  NodeComponent({
    required this.state,
    required this.node,
  }) : super(
          size: Constants.NODE_SIZE,
          position: node.position,
          anchor: Anchor.center,
          priority: Priority.nodes.value,
        );

  @override
  Future onLoad() async {
    paint.color = Palette.grey;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.stroke;

    add(CircleHitbox(
      radius: size.x / 2,
      position: size / 2,
      anchor: Anchor.center,
      isSolid: true,
    ));

    add(LabelComponent(
      text: node.type.name,
      position: size / 2,
      size: size.x / 8,
      color: Palette.white,
    ));

    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is UnitComponent) {
      final double distance = other.unit.position.distanceTo(position);

      if (distance < 3) {
        _captureNode(other.unit);
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  void _captureNode(Unit unit) {
    if (node.owner != unit.owner) {
      final Player? previousOwner = node.owner;
      final Player newOwner = unit.owner;

      node.setOwner(newOwner);
      paint.color = newOwner.color;

      state.onNodeCaptured(
        node: node,
        newOwner: newOwner,
        previousOwner: previousOwner,
      );
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      (size / 2).toOffset(),
      Constants.NODE_SIZE.x / 2,
      paint,
    );

    if (node.type.canAccumulate) {
      const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 30,
      );
      final textSpan = TextSpan(
        text: node.commandPointsAccumulated.toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: 100,
      );
      final offset = (size / 2).toOffset();
      textPainter.paint(canvas, Offset(offset.dx - 10, offset.dy + 20));
    }
  }
}
