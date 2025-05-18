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
    add(
      BattlefieldGridComponent(
        battlefield: battlefield,
        position: Dimensions.battlefildGridPosition(size),
        size: Dimensions.battlefildGridSize(
          size: size,
          battlefield: battlefield,
        ),
        nodeComponents: nodeComponents,
      ),
    );

    return super.onLoad();
  }
}

class BattlefieldGridComponent extends PositionComponent {
  final Battlefield battlefield;
  final List<NodeComponent> nodeComponents;
  final Paint paintBackground = Paint();
  final Paint paintGrid = Paint();

  BattlefieldGridComponent({
    required this.battlefield,
    required super.position,
    required super.size,
    required this.nodeComponents,
  }) : super(anchor: Anchor.center) {
    paintBackground.color = const Color(0xff444444);
    paintBackground.style = PaintingStyle.fill;

    paintGrid.color = Colors.black;
    paintGrid.style = PaintingStyle.stroke;
  }

  @override
  FutureOr onLoad() {
    final double gap = (size.x / battlefield.size.width) / 100;
    paintGrid.strokeWidth = gap;

    final Vector2 nodeSize = Dimensions.nodeSize(
      size: size,
      battlefield: battlefield,
    );
    final Set<String> existingNodes = {};

    for (final Node node in battlefield.nodes) {
      if (existingNodes.contains(node.id)) {
        throw Exception('Duplicated node: ${node.id}');
      } else {
        final NodeComponent nodeComponent = node.component(
          position: Dimensions.nodePosition(
            nodeSize: nodeSize,
            location: node.location,
          ),
          size: Vector2(nodeSize.x - gap, nodeSize.y - gap),
        );
        existingNodes.add(node.id);
        nodeComponents.add(nodeComponent);
        add(nodeComponent);
      }
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paintBackground);

    final double gap = size.x / battlefield.size.width;

    for (int i = 1; i < battlefield.size.width; i++) {
      canvas.drawLine(Offset(i * gap, 0), Offset(i * gap, size.y), paintGrid);
    }

    for (int j = 1; j < battlefield.size.height; j++) {
      canvas.drawLine(Offset(0, j * gap), Offset(size.x, j * gap), paintGrid);
    }
  }
}
