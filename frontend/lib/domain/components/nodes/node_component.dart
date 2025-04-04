import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent<N extends Node> extends PositionComponent
    with HoverCallbacks, MatchComponentRef, TapCallbacks {
  final N node;
  NodeHighlitedComponent? nodeHighlitedComponent;
  NodeSelectedComponent? nodeSelectedComponent;
  UnitComponent? unitComponent;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);

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
    if ((nodeHighlitedComponent == null) && !_isSelected) {
      nodeHighlitedComponent = NodeHighlitedComponent(
        position: absolutePosition,
        size: size,
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

  void _showSelected() {
    if (nodeSelectedComponent == null) {
      nodeSelectedComponent = NodeSelectedComponent(
        position: absolutePosition,
        size: size,
        color: node.playerColor!,
      );
      match.add(nodeSelectedComponent!);
      match.selectNode(this);
      _hideHighlighted();
    }
  }

  void hideSelected() {
    if (nodeSelectedComponent != null) {
      match.remove(nodeSelectedComponent!);
      match.selectNode(null);
      nodeSelectedComponent = null;
    }
  }

  void _toggleSelected() {
    if (nodeSelectedComponent == null) {
      _showSelected();
    } else {
      hideSelected();
    }
  }

  bool get _isSelected => nodeSelectedComponent != null;

  bool get _belongsToSelf => node.belongsTo(match.self);

  bool get _canBeHighlighted => _canBeSelected || match.isMovementTarget(this);

  bool get _canBeSelected => _belongsToSelf && node.containsUnit;

  @override
  void onTapUp(TapUpEvent event) {
    if (_canBeSelected) {
      if (!_isSelected) {
        match.unselectNodes();
      }

      _toggleSelected();
    } else if (match.isMovementTarget(this)) {
      match.moveUnitTo(this);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (node.containsUnit && (unitComponent == null)) {
      unitComponent = node.unit.component(position: size / 2, size: size / 1.5);
      add(unitComponent!);
    } else if (!node.containsUnit && (unitComponent != null)) {
      remove(unitComponent!);
      unitComponent = null;
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
    : super(anchor: Anchor.center, priority: Priority.node.value) {
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
  );

  NodeSelectedComponent({
    required super.position,
    required super.size,
    required Color color,
  }) : super(anchor: Anchor.center, priority: Priority.node.value) {
    selectedPaint.strokeWidth = size.x / 15;
    selectedPaint.color = color;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawHexagon(size: size, borderPaint: selectedPaint);
  }
}
