import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/label_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeComponent extends SpriteComponent with CollisionCallbacks {
  final GameState state;
  final Node node;
  String? owner;
  LabelComponent? labelComponent;

  NodeComponent({
    required this.state,
    required this.node,
  }) : super(
          sprite: Sprites.NODE,
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
    ));

    super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is UnitComponent) {
      owner = other.unit.owner;
      refresh();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  void refresh() {
    if (owner != null) {
      if (labelComponent != null) {
        remove(labelComponent!);
      }

      labelComponent = LabelComponent(
        text: owner!,
        position: size / 2,
        size: size.x / 4,
        color: (owner == Constants.PLAYER_SELF) ? Palette.blue : Palette.red,
      );

      add(labelComponent!);
    }
  }
}
