import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/fog_component.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent<N extends Node> extends PositionComponent
    with HoverCallbacks
    implements Reconfigurable {
  final N node;
  NodeHighlitedComponent? _nodeHighlitedComponent;
  UnitComponent? _unitComponent;
  StructureComponent? _structureComponent;
  FogComponent? _fogComponent;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);

  bool get _canBeHighlighted => false;

  void onHighlighted(bool enabled) {
    if (enabled) {
      _showHighlighted();
    } else {
      _hideHighlighted();
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  @override
  void onHoverEnter() {
    if (_canBeHighlighted) {
      _showHighlighted();
    }
  }

  @override
  void onHoverExit() => _hideHighlighted();

  void _showHighlighted() {
    if (_nodeHighlitedComponent == null) {
      _nodeHighlitedComponent = NodeHighlitedComponent(
        position: absolutePosition,
        size: size * 0.96,
      );
      match.add(_nodeHighlitedComponent!);
    }
  }

  void _hideHighlighted() {
    if (_nodeHighlitedComponent != null) {
      match.remove(_nodeHighlitedComponent!);
      _nodeHighlitedComponent = null;
    }
  }

  @override
  FutureOr onLoad() async {
    if (node.type.sprite != null) {
      add(NodeBackground(node: node, position: size / 2, size: size));
    }

    reconfigure();

    return super.onLoad();
  }

  @override
  void reconfigure() {
    if (node.hasStructure && (_structureComponent == null)) {
      _structureComponent = node.structure!.component(
        position: size / 2,
        size: size,
      );
      add(_structureComponent!);
    } else if (!node.hasStructure && (_structureComponent != null)) {
      remove(_structureComponent!);
      _structureComponent = null;
    }

    if (node.isRevealed) {
      if (_fogComponent != null) {
        match.remove(_fogComponent!);
        _fogComponent = null;
      }

      if (node.hasUnit && (_unitComponent == null)) {
        _unitComponent = node.unit!.component(
          node: node,
          position: absolutePosition,
          size: size / 1.5,
        );
        match.add(_unitComponent!);
      } else if (!node.hasUnit && (_unitComponent != null)) {
        match.remove(_unitComponent!);
        _unitComponent = null;
      }
    } else {
      if (_unitComponent != null) {
        match.remove(_unitComponent!);
        _unitComponent = null;
      }

      if (_fogComponent == null) {
        _fogComponent =
            _fogComponent = FogComponent(
              position: absolutePosition,
              size: size,
            );
        match.add(_fogComponent!);
      }
    }
  }

  /*@override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '${node.location}',
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
  }*/
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

class NodeBackground<N extends Node> extends SpriteComponent {
  final N node;
  final Vector2 initialPosition = Vector2(0, 0);

  NodeBackground({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(node.type.sprite!);

    return super.onLoad();
  }
}
