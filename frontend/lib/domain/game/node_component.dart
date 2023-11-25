import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/label_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeComponent extends SpriteComponent with TapCallbacks, GestureHitboxes {
  final GameState state;
  final Node node;

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
    add(LabelComponent(
      text: node.id,
      position: size / 2,
      size: size.x / 3,
      color: Palette.grey,
    ));

    add(CircleHitbox(
      radius: size.x / 2,
      position: size / 2,
      anchor: Anchor.center,
    ));

    super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) => state.onNodeSelected(node);
}
