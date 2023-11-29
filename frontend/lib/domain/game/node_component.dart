import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/label_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeComponent extends SpriteComponent
    with CollisionCallbacks, TapCallbacks {
  final GameState state;
  final Node node;

  NodeComponent({
    required this.state,
    required this.node,
  }) : super(
          sprite: node.sprite,
          size: Constants.NODE_SIZE,
          position: node.position,
          anchor: Anchor.center,
          priority: Priority.nodes.value,
        );

  @override
  Future onLoad() async {
    add(CircleHitbox(
      radius: size.x / 2,
      position: size / 2,
      anchor: Anchor.center,
      isSolid: true,
    ));

    if (!node.type.isLauncher) {
      add(LabelComponent(
        text: node.type.name,
        position: size / 2,
        size: size.x / 8,
        color: Palette.white,
      ));
    }

    super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (node.type.isLauncher &&
        (other is UnitComponent) &&
        (node.owner != other.owner)) {
      state.onUnitCollidedWithBase(
        unit: other.unit,
        baseOwner: node.owner!,
      );
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is UnitComponent) {
      final double distance = other.unit.position.distanceTo(position);

      if (distance < 3) {
        _captureNode(other.unit);
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if ((node.type.canLaunch) && node.hasOwner) {
      state.onNodeSpawnUnit(
        node: node,
        power: Random().nextInt(10) + 1,
      );
    }
  }

  void _captureNode(Unit unit) {
    if (node.type.canBeCaptured && (node.owner != unit.owner)) {
      final Player? previousOwner = node.owner;
      final Player newOwner = unit.owner;

      node.setOwner(newOwner);

      if (newOwner.isEnemy) {
        sprite = Sprites.NODE_ENEMY;
      } else if (newOwner.isSelf) {
        sprite = Sprites.NODE_SELF;
      }

      if (node.type.isVictory) {
        state.onNodeVictoryCaptured(node);
      } else if (node.type.isCommandPointsGenerator) {
        state.onNodeCommandPointsGeneratorCaptured(
          node: node,
          previousOwner: previousOwner,
          newOwner: newOwner,
        );
      }
    } else if (node.type.isChest) {
      state.onNodeChestAcquired(
        node: node,
        player: unit.owner,
      );
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (node.type.canAccumulate) {
      const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 30,
      );
      final textSpan = TextSpan(
        text: node.commandPointsAccumulated.toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: 100,
      );
      final offset = (size / 2).toOffset();
      textPainter.paint(canvas, Offset(offset.dx - 10, offset.dy + 20));
    }
  }
}
