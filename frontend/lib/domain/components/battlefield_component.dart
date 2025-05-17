import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/dimensions.dart';

class BattlefieldComponent extends PositionComponent {
  final Battlefield battlefield;
  final List<NodeComponent> nodeComponents;

  BattlefieldComponent({
    required this.battlefield,
    required super.position,
    required super.size,
    required this.nodeComponents,
  }) : super(anchor: Anchor.topLeft, priority: Priority.battlefield.value);

  @override
  FutureOr onLoad() async {
    final Vector2 gridSize = Dimensions.battlefildGridSize(size);

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

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    paint.style = PaintingStyle.stroke;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
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
  }) : super(anchor: Anchor.center);

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
          location: node.location,
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
