import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/actions_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class BattlefieldComponent extends PositionComponent {
  final Match match;
  final List<NodeComponent> nodeComponents;
  final Paint paintBackground = Palette.paint(
    color: Palette.BATTLEFIELD_BACKGROUND,
    style: PaintingStyle.fill,
  );

  BattlefieldComponent({
    required this.match,
    required super.position,
    required super.size,
    required this.nodeComponents,
  }) : super(anchor: Anchor.center, priority: Priority.battlefield.value);

  @override
  FutureOr onLoad() async {
    add(
      BattlefieldGridComponent(
        match: match,
        position: Dimensions.battlefildGridPosition(size),
        size: Dimensions.battlefildGridSize(size),
        nodeComponents: nodeComponents,
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paintBackground);
  }
}

class BattlefieldGridComponent extends PositionComponent {
  final Match match;
  final List<NodeComponent> nodeComponents;

  BattlefieldGridComponent({
    required this.match,
    required super.position,
    required super.size,
    required this.nodeComponents,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() {
    final Vector2 nodeSize = Dimensions.nodeSize(
      size: size,
      battlefield: match.battlefield,
    );
    final Set<String> existingNodes = {};
    final Vector2 center = size / 2;

    for (final Node node in match.battlefield.nodes) {
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
          size: nodeSize,
        );
        existingNodes.add(node.id);
        nodeComponents.add(nodeComponent);
        add(nodeComponent);
      }
    }

    add(
      ActionsComponent(
        player: match.self,
        nodeSize: nodeSize,
        position: size / 2,
        size: size,
      ),
    );

    return super.onLoad();
  }
}
