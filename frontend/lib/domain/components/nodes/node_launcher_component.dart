import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';

class NodeLauncherComponent extends NodeComponent
    with CollisionCallbacks, TapCallbacks {
  final Paint backgroundPaint = Paint();

  NodeLauncherComponent({
    required super.id,
    required super.owner,
    required super.position,
    required super.size,
  }) : super(rate: 0);

  @override
  FutureOr onLoad() {
    add(CircleHitbox());

    if (owner!.isEnemy) {
      backgroundPaint.color = Colors.red.shade900;
    } else if (owner!.isSelf) {
      backgroundPaint.color = Colors.blue.shade900;
    }

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) && (owner != other.owner)) {
      _onUnitCollided(other);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (hasOwner && owner!.hasCreditsSelected) {
      spawnUnitOfPlayer(owner!);
    }
  }

  void _onUnitCollided(UnitComponent unit) =>
      GameState.instance.onUnitCollidedWithBase(
        unit: unit,
        baseOwner: owner!,
      );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      backgroundPaint,
    );
  }
}
