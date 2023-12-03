import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/game/nodes/node_base_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';

class NodeLauncherComponent extends NodeBaseLauncherComponent
    with CollisionCallbacks, TapCallbacks {
  NodeLauncherComponent({
    required super.node,
    required super.size,
  });

  @override
  Future onLoad() async {
    add(CircleHitbox(
      radius: size.x / 2,
      position: size / 2,
      anchor: Anchor.center,
      isSolid: true,
    ));

    super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) && (node.owner != other.owner)) {
      node.onUnitCollidedWithBase(other.unit);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (node.hasOwner) {
      node.onSpawnUnit();
    }
  }
}
