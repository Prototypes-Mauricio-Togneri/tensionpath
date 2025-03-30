import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class BattlefieldComponent extends PositionComponent {
  final Battlefield battlefield;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.BATTLEFIELD_BACKGROUND,
  );

  BattlefieldComponent({
    required this.battlefield,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.battlefield.value);

  @override
  FutureOr onLoad() async {
    final double padding = size.y * 0.1;

    final Sprite sprite = await Sprite.load(
      Assets.IMAGES_BATTLEFIELDS_BACKGROUND,
    );
    final double ratio = sprite.originalSize.x / sprite.originalSize.y;
    final double gridHeight = size.y - padding;
    final double backgroundHeightAdjusted =
        gridHeight / battlefield.gridHeightRatio;
    final double backgroundWidthAdjusted = backgroundHeightAdjusted * ratio;

    add(
      BattlefieldBackgroundComponent(
        sprite: sprite,
        position: size / 2,
        size: Vector2(backgroundWidthAdjusted, backgroundHeightAdjusted),
      ),
    );

    add(
      BattlefieldGridComponent(
        battlefield: battlefield,
        position: size / 2,
        size: Vector2(size.x - padding, size.y - padding),
      ),
    );

    return super.onLoad();
  }
}

class BattlefieldGridComponent extends PositionComponent {
  final Battlefield battlefield;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Colors.red,
  );

  BattlefieldGridComponent({
    required this.battlefield,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.battlefield.value);

  @override
  FutureOr onLoad() {
    final Size nodeSize = Dimensions.nodeSize(
      canvasSize: size,
      battlefieldSize: battlefield.size,
    );
    final Vector2 mapCenter = size / 2;
    final Set<String> existingNodes = {};

    for (final Node node in battlefield.nodes) {
      if (existingNodes.contains(node.id)) {
        throw Exception('Duplicated node: ${node.id}');
      } else {
        final Vector2 position = Dimensions.nodePosition(
          nodeSize: nodeSize,
          x: node.x,
          y: node.y,
        );

        add(
          node.component(
            position: Vector2(
              mapCenter.x + position.x,
              mapCenter.y + position.y,
            ),
            size: Vector2(nodeSize.height, nodeSize.height),
          ),
        );

        existingNodes.add(node.id);
      }
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fillPaint);
  }
}

class BattlefieldBackgroundComponent extends SpriteComponent {
  BattlefieldBackgroundComponent({
    required super.sprite,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.battlefield.value);
}
