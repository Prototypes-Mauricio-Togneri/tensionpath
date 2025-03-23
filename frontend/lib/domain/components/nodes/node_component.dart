import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';

class NodeComponent<N extends Node> extends PositionComponent {
  final N node;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '${node.x},${node.y}',
      position: size / 2,
      size: size.x / 5,
      color: Colors.white,
    );
  }
}
