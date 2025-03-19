import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class BattlefieldComponent extends PositionComponent {
  final Battlefield battlefield;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: const Color(0xff222222),
  );

  BattlefieldComponent({
    required this.battlefield,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.battlefield.value);

  @override
  FutureOr onLoad() {
    final double nodeSize = size.x / battlefield.size.width;

    for (final Node node in battlefield.nodes) {
      add(
        node.component(
          position: Vector2(
            (nodeSize * node.x) + (nodeSize / 2),
            (nodeSize * node.y) + (nodeSize / 2),
          ),
          size: Vector2(nodeSize, nodeSize),
        ),
      );
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);
  }
}
