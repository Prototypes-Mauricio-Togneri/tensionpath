import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent extends PositionComponent {
  final NodeType type;
  final Location location;
  final Position remotePosition;
  final Paint highlightedPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.NODE_HIGHLIGHTED,
  );
  bool isRevealed = false;
  bool isHighlighted = false;
  UnitComponent? lockedUnit;

  NodeComponent({
    required super.position,
    required super.size,
    required this.type,
    required this.location,
    required this.remotePosition,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.node.value,
       );

  void lock(UnitComponent unit) {
    lockedUnit = unit;
  }

  void unlock() {
    lockedUnit = null;
  }

  @override
  bool containsLocalPoint(Vector2 point) => Dimensions.pointInCircle(
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

  void revealedNodes({
    required int visibilityRange,
    required List<NodeComponent> nodes,
    required Set<Vector2> revealedNodes,
  }) {
    revealedNodes.add(position);
    isRevealed = true;

    for (final NodeComponent node in nodes) {
      if ((node != this) && (distanceTo(node) <= visibilityRange)) {
        node.isRevealed = true;
        revealedNodes.add(node.position);
      }
    }
  }

  void highlight(bool value) {
    isHighlighted = value;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (isHighlighted) {
      canvas.drawHexagon(
        center: size / 2,
        size: size,
        borderPaint: highlightedPaint,
      );
    }

    /*final double fontSize = size.x / 12;
    const double gap = 1 / 9;

    canvas.drawText(
      text: type.name,
      position: Vector2(size.x / 2, size.y * gap * 2),
      size: fontSize,
      color: Palette.TEXT_DEBUG,
    );

    canvas.drawText(
      text: 'Location: ${location.id}',
      position: Vector2(size.x / 2, size.y * gap * 3),
      size: fontSize,
      color: Palette.TEXT_DEBUG,
    );

    canvas.drawText(
      text:
          'Absolute: ${absolutePosition.x.toStringAsFixed(2)},${absolutePosition.y.toStringAsFixed(2)}',
      position: Vector2(size.x / 2, size.y * gap * 4),
      size: fontSize,
      color: Palette.TEXT_DEBUG,
    );

    canvas.drawText(
      text:
          'Relative: ${position.x.toStringAsFixed(2)},${position.y.toStringAsFixed(2)}',
      position: Vector2(size.x / 2, size.y * gap * 5),
      size: fontSize,
      color: Palette.TEXT_DEBUG,
    );

    canvas.drawText(
      text:
          'Remote: ${remotePosition.x.toStringAsFixed(2)},${remotePosition.y.toStringAsFixed(2)}',
      position: Vector2(size.x / 2, size.y * gap * 6),
      size: fontSize,
      color: Palette.TEXT_DEBUG,
    );*/
  }
}
