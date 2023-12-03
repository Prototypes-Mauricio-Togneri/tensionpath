import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/game/label_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeComponent extends SpriteComponent
    with CollisionCallbacks, TapCallbacks {
  final Node node;
  final Paint ownershipPaint = Paint();

  NodeComponent({
    required this.node,
    required super.size,
  }) : super(
          sprite: node.sprite,
          position: node.position,
          anchor: Anchor.center,
          priority: Priority.nodes.value,
        );

  @override
  Future onLoad() async {
    ownershipPaint.style = PaintingStyle.stroke;
    ownershipPaint.strokeWidth = 10;

    add(circleHitbox);

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
  void update(double dt) {
    final bool shouldUpdate = node.update(dt);

    if (shouldUpdate && node.type.canBeCaptured) {
      if (node.hasOwner) {
        if (node.owner!.isEnemy) {
          sprite = Sprites.NODE_ENEMY;
        } else if (node.owner!.isSelf) {
          sprite = Sprites.NODE_SELF;
        }
      } else {
        sprite = Sprites.NODE_NEUTRAL;
      }
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is UnitComponent) {
      if (node.type.isLauncher && (node.owner != other.owner)) {
        node.onUnitCollidedWithBase(other.unit);
      } else if (node.type.canBeCaptured) {
        node.onTouched(other.owner);
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (node.type.canLaunch && node.hasOwner) {
      node.onSpawnUnit();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (node.type.isChest) {
      const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 30,
      );
      final textSpan = TextSpan(
        text: node.creditsAccumulated.toString(),
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
      textPainter.paint(canvas, Offset(offset.dx - 10, offset.dy + 10));
    }

    if (node.ownership.hasTouched) {
      ownershipPaint.color = node.ownership.color;

      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.x, size.y),
        -pi / 2,
        2 * pi * node.ownership.value,
        false,
        ownershipPaint,
      );
    }
  }
}
