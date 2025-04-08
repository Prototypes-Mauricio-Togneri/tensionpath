import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent<N extends Node> extends PositionComponent
    with HoverCallbacks {
  final N node;
  NodeHighlitedComponent? nodeHighlitedComponent;
  UnitComponent? unitComponent;
  StructureComponent? structureComponent;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);

  bool get _belongsToSelf => node.belongsTo(match.match.self);

  bool get _canBeHighlighted =>
      match.match.isSelfTurn && _belongsToSelf && node.hasUnit;

  void onHighlighted(bool enabled) {
    if (enabled) {
      _showHighlighted();
    } else {
      _hideHighlighted();
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    final Vector2 fromCenter = point - (size / 2);

    return fromCenter.length < size.x * 0.42;
  }

  @override
  void onHoverEnter() {
    if (_canBeHighlighted) {
      _showHighlighted();
    }
  }

  @override
  void onHoverExit() => _hideHighlighted();

  void _showHighlighted() {
    if (nodeHighlitedComponent == null) {
      nodeHighlitedComponent = NodeHighlitedComponent(
        position: absolutePosition,
        size: size * 0.96,
      );
      match.add(nodeHighlitedComponent!);
    }
  }

  void _hideHighlighted() {
    if (nodeHighlitedComponent != null) {
      match.remove(nodeHighlitedComponent!);
      nodeHighlitedComponent = null;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (node.hasUnit && (unitComponent == null)) {
      unitComponent = node.unit.component(
        node: node,
        position: absolutePosition,
        size: size / 1.5,
      );
      match.add(unitComponent!);
    } else if (!node.hasUnit && (unitComponent != null)) {
      match.remove(unitComponent!);
      unitComponent = null;
    }

    if (node.hasStructure && (structureComponent == null)) {
      structureComponent = node.structure.component(
        position: size / 2,
        size: size,
      );
      add(structureComponent!);
    } else if (!node.hasStructure && (structureComponent != null)) {
      remove(structureComponent!);
      structureComponent = null;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (debugMode) {
      canvas.drawText(
        text: '${node.x},${node.y}',
        position: Vector2(size.x / 2, size.y / 4),
        size: size.x / 8,
        color: Colors.white,
      );

      canvas.drawText(
        text: '${absolutePosition.x.toInt()},${absolutePosition.y.toInt()}',
        position: Vector2(size.x / 2, size.y * 2 / 4),
        size: size.x / 8,
        color: Colors.white,
      );
    }
  }
}

class NodeHighlitedComponent extends PositionComponent {
  final Paint highlightedPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.NODE_BORDER,
  );

  NodeHighlitedComponent({required super.position, required super.size})
    : super(anchor: Anchor.center) {
    highlightedPaint.strokeWidth = size.x / 20;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawHexagon(size: size, borderPaint: highlightedPaint);
  }
}

class NodeSelectedComponent extends PositionComponent {
  final Paint selectedPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.NODE_BORDER,
    strokeCap: StrokeCap.round,
    strokeJoin: StrokeJoin.round,
  );

  NodeSelectedComponent({
    required super.position,
    required super.size,
    required Color color,
  }) : super(anchor: Anchor.center) {
    selectedPaint.strokeWidth = size.x / 20;
    selectedPaint.color = color;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawHexagon(size: size, borderPaint: selectedPaint);
  }
}
