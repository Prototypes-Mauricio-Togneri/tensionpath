import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class BattlefieldComponent extends PositionComponent {
  final Battlefield battlefield;
  final List<NodeComponent> nodeComponents = [];
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
    final Sprite sprite = await Sprite.load(
      Assets.IMAGES_BATTLEFIELDS_BACKGROUND,
    );
    final Vector2 gridSize = Dimensions.battlefildGridSize(size);

    add(
      BattlefieldBackgroundComponent(
        sprite: sprite,
        position: size / 2,
        size: Dimensions.battlefieldBackgroundSize(
          canvasSize: size,
          imageSize: sprite.originalSize,
          gridSize: gridSize,
          battlefield: battlefield,
        ),
      ),
    );

    add(
      BattlefieldGridComponent(
        battlefield: battlefield,
        position: size / 2,
        size: gridSize,
        nodeComponents: nodeComponents,
      ),
    );

    return super.onLoad();
  }
}

class BattlefieldGridComponent extends PositionComponent {
  final Battlefield battlefield;
  final List<NodeComponent> nodeComponents;

  BattlefieldGridComponent({
    required this.battlefield,
    required super.position,
    required super.size,
    required this.nodeComponents,
  }) : super(anchor: Anchor.center, priority: Priority.battlefield.value);

  @override
  FutureOr onLoad() {
    final Size nodeSize = Dimensions.nodeSize(
      canvasSize: size,
      battlefield: battlefield,
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

        final NodeComponent nodeComponent = node.component(
          position: Vector2(mapCenter.x + position.x, mapCenter.y + position.y),
          size: Vector2(nodeSize.height, nodeSize.height),
        );
        nodeComponents.add(nodeComponent);
        add(nodeComponent);

        existingNodes.add(node.id);
      }
    }

    return super.onLoad();
  }
}

class BattlefieldBackgroundComponent extends SpriteComponent {
  BattlefieldBackgroundComponent({
    required super.sprite,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.battlefield.value);
}
