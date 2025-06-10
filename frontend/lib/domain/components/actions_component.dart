import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart' hide Actions, Action;
import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_unit.dart';
import 'package:tensionpath/domain/entities/actions/action_move_unit.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class ActionsComponent extends PositionComponent {
  final Player player;
  final Vector2 nodeSize;
  final Paint outterPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint innerPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint movementPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.UNIT_MOVEMENT_INDICATOR_VALID,
  );

  ActionsComponent({
    required this.player,
    required this.nodeSize,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.actions.value) {
    outterPaint.color = player.color.brighten(0.5);
    innerPaint.color = player.color;
  }

  @override
  void render(Canvas canvas) {
    final Vector2 center = size / 2;

    for (final Action action in player.actions) {
      if (action is ActionDeployUnit) {
        _renderDeploy(
          action: action,
          nodeSize: nodeSize,
          center: center,
          canvas: canvas,
        );
      } else if (action is ActionMoveUnit) {
        _renderMove(
          action: action,
          nodeSize: nodeSize,
          center: center,
          canvas: canvas,
        );
      }
    }
  }

  void _renderDeploy({
    required ActionDeployUnit action,
    required Vector2 nodeSize,
    required Vector2 center,
    required Canvas canvas,
  }) {
    final Vector2 position =
        Dimensions.nodePosition(nodeSize: nodeSize, location: action.target) +
        center;

    canvas.drawUnitCircle(
      position: position,
      size: nodeSize,
      outterPaint: outterPaint,
      innerPaint: innerPaint,
      level: action.level,
      angle: (match.match.self.isPlayer2) ? pi : 0,
    );
  }

  void _renderMove({
    required ActionMoveUnit action,
    required Vector2 nodeSize,
    required Vector2 center,
    required Canvas canvas,
  }) {
    final Vector2 origin =
        Dimensions.nodePosition(nodeSize: nodeSize, location: action.origin) +
        center;
    final Vector2 target =
        Dimensions.nodePosition(nodeSize: nodeSize, location: action.target) +
        center;

    canvas.movementLine(
      origin: origin,
      target: target,
      radius: nodeSize.x,
      paint: movementPaint,
      moving: false,
    );
  }
}
