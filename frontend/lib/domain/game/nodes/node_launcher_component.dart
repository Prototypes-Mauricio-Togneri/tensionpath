import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/types/priority.dart';

class NodeLauncherComponent extends SpriteComponent
    with CollisionCallbacks, TapCallbacks {
  final Node node;

  NodeLauncherComponent({
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
