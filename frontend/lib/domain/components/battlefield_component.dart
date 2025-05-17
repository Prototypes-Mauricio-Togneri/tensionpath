import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/location.dart';
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

  BattlefieldGridComponent({
    required this.battlefield,
    required super.position,
    required super.size,
    required this.nodeComponents,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() {
    final Vector2 nodeSize = Vector2(
      size.x / battlefield.size.width,
      size.y / battlefield.size.height,
    );
    final Set<String> existingNodes = {};

    for (int i = 0; i < battlefield.size.width; i++) {
      for (int j = 0; j < battlefield.size.height; j++) {
        final Node node = battlefield.nodes[0];

        if (existingNodes.contains(node.id)) {
          throw Exception('Duplicated node: ${node.id}');
        } else {
          final NodeComponent nodeComponent = node.component(
            position: Dimensions.nodePosition(
              nodeSize: nodeSize,
              location: Location(x: i, y: j),
            ),
            size: nodeSize,
          );
          nodeComponents.add(nodeComponent);
          add(nodeComponent);

          // TODO(momo): Uncomment when using real nodes from the list
          // existingNodes.add(node.id);
        }
      }
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint paintBackground = Paint();
    paintBackground.color = const Color(0xff444444);
    paintBackground.style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paintBackground);

    final double gap = size.x / battlefield.size.width;

    final Paint paintGrid = Paint();
    paintGrid.color = Colors.black;
    paintGrid.strokeWidth = gap / 100;
    paintGrid.style = PaintingStyle.stroke;

    for (int i = 1; i < battlefield.size.width; i++) {
      canvas.drawLine(Offset(i * gap, 0), Offset(i * gap, size.y), paintGrid);
    }

    for (int j = 1; j < battlefield.size.height; j++) {
      canvas.drawLine(Offset(0, j * gap), Offset(size.x, j * gap), paintGrid);
    }
  }
}
