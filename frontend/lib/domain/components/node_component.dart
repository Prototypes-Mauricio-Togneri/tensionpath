import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/units_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent<N extends Node> extends PositionComponent
    implements Reconfigurable {
  final N node;
  UnitsComponent? _unitsComponent;
  StructureComponent? _structureComponent;
  //FogComponent? _fogComponent;
  final Paint backgroundPaint = Palette.paint(
    color: Palette.NODE_BACKGROUND,
    style: PaintingStyle.fill,
  );

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);

  @override
  FutureOr onLoad() async {
    reconfigure();

    return super.onLoad();
  }

  @override
  void reconfigure() {
    if (node.hasStructure && (_structureComponent == null)) {
      _structureComponent = node.structure!.component(
        node: node,
        position: size / 2,
        size: size,
      );
      add(_structureComponent!);
    } else if (!node.hasStructure && (_structureComponent != null)) {
      remove(_structureComponent!);
      _structureComponent = null;
    }

    if (node.isRevealed) {
      /*if (_fogComponent != null) {
        remove(_fogComponent!);
        _fogComponent = null;
      }*/

      if (node.hasUnits && (_unitsComponent == null)) {
        _unitsComponent = node.units!.component(
          node: node,
          position: size / 2,
          size: size / 1.5,
        );
        add(_unitsComponent!);
      } else if (!node.hasUnits && (_unitsComponent != null)) {
        remove(_unitsComponent!);
        _unitsComponent = null;
      }
    } else {
      if (_unitsComponent != null) {
        remove(_unitsComponent!);
        _unitsComponent = null;
      }

      /*if (_fogComponent == null) {
        _fogComponent =
            _fogComponent = FogComponent(
              position: size / 2,
              size: size,
            );
        add(_fogComponent!);
      }*/
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawHexagon(
      center: size / 2,
      size: size * 0.97,
      borderPaint: backgroundPaint,
    );

    canvas.drawText(
      text: node.location.toString(),
      color: Palette.DEBUG_TEXT,
      position: size / 2,
      size: size.x / 6,
    );
  }
}
