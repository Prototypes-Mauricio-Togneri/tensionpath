import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent<N extends Node> extends PositionComponent
    with HoverCallbacks, MatchComponentRef {
  final Paint highlightPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.NODE_BORDER,
  );
  final N node;
  bool highlight = false;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value) {
    highlightPaint.strokeWidth = size.x / 20;
  }

  @override
  FutureOr onLoad() {
    add(
      CircleHitbox(
        radius: size.x * 0.42,
        anchor: Anchor.center,
        position: size / 2,
        isSolid: true,
      ),
    );

    return super.onLoad();
  }

  void deployUnit(Unit unit) {
    node.deployUnit(unit);

    final UnitComponent unitComponent = unit.component(
      position: size / 2,
      size: size / 1.5,
    );

    add(unitComponent);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (debugMode) {
      canvas.drawText(
        text: '${node.x},${node.y}',
        position: Vector2(size.x / 2, size.y / 3),
        size: size.x / 5,
        color: Colors.white,
      );

      canvas.drawText(
        text: '${absolutePosition.x.toInt()},${absolutePosition.y.toInt()}',
        position: Vector2(size.x / 2, size.y * 2 / 3),
        size: size.x / 7,
        color: Colors.white,
      );
    }

    if ((isHovered && (node.player == match.self)) || highlight) {
      canvas.drawHexagon(size: size, borderPaint: highlightPaint);
    }
  }
}
