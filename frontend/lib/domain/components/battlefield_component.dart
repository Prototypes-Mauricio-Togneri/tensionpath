import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

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
        size: Dimensions.battlefildGridSize(size),
        nodeComponents: nodeComponents,
      ),
    );

    return super.onLoad();
  }
}

class BattlefieldGridComponent extends PositionComponent {
  final Battlefield battlefield;
  final List<NodeComponent> nodeComponents;
  final Paint paintBackground = Palette.paint(
    color: const Color(0xff444444),
    style: PaintingStyle.fill,
  );
  final Paint paintGrid = Palette.paint(
    color: Colors.black,
    style: PaintingStyle.stroke,
  );

  BattlefieldGridComponent({
    required this.battlefield,
    required super.position,
    required super.size,
    required this.nodeComponents,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() {
    final double gap = (size.x / battlefield.size.width) / 100;
    paintGrid.strokeWidth = gap;

    final Vector2 nodeSize = Dimensions.nodeSize(
      size: size,
      battlefield: battlefield,
    );
    final Set<String> existingNodes = {};
    final Vector2 center = size / 2;

    for (final Node node in battlefield.nodes) {
      if (existingNodes.contains(node.id)) {
        throw Exception('Duplicated node: ${node.id}');
      } else {
        final NodeComponent nodeComponent = node.component(
          position:
              Dimensions.nodePosition(
                nodeSize: nodeSize,
                location: node.location,
              ) +
              center,
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
  }
}
