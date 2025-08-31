import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/json/json_location.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent extends PositionComponent {
  final NodeType type;
  final JsonLocation location;
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 5,
    color: Palette.NODE_HIGHLIGHT,
  );
  bool highlighted = false;

  NodeComponent({
    required super.position,
    required super.size,
    required this.type,
    required this.location,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.node.value,
       );

  @override
  bool containsLocalPoint(Vector2 point) => Dimensions.pointInHexagon(
    point: point,
    size: size,
  );

  int distanceTo(NodeComponent node) {
    final double distance =
        ((location.x - node.location.x).abs() +
            (location.x + location.y - node.location.x - node.location.y)
                .abs() +
            (location.y - node.location.y).abs()) /
        2;

    return distance.toInt();
  }

  void visibleNodes({
    required int visibilityRange,
    required List<NodeComponent> nodes,
    required Set<Vector2> visibleNodes,
  }) {
    visibleNodes.add(position);

    for (final NodeComponent node in nodes) {
      if ((node != this) && (distanceTo(node) <= visibilityRange)) {
        visibleNodes.add(node.position);
      }
    }
  }

  void highlight(bool value) {
    highlighted = value;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (highlighted) {
      canvas.drawHexagon(
        center: size / 2,
        size: size,
        borderPaint: borderPaint,
      );
    }

    /*canvas.drawText(
      text: type.name,
      position: Vector2(size.x / 2, size.y * 0.25),
      size: size.x / 8,
      color: Colors.white,
    );

    canvas.drawText(
      text: jsonPosition.id,
      position: Vector2(size.x / 2, size.y * 0.5),
      size: size.x / 8,
      color: Colors.white,
    );

    canvas.drawText(
      text: '${absolutePosition.x.toInt()},${absolutePosition.y.toInt()}',
      position: Vector2(size.x / 2, size.y * 0.75),
      size: size.x / 8,
      color: Colors.white,
    );*/
  }
}
