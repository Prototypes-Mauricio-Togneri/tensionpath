import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
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
    final double nodeSize =
        (size.x / battlefield.size.width) * (1 - Constants.UI_PADDING_RATIO);
    final Vector2 center = size / 2;

    for (final Node node in battlefield.nodes) {
      final int q = node.x;
      final int r = node.y;

      final double x = nodeSize * (3 / 2 * q);
      final double y = nodeSize * (sqrt(3) / 2 * q + sqrt(3) * r);

      add(
        node.component(
          position: Vector2(center.x + x, center.y + y),
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
