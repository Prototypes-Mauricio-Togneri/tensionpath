import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';
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
          size: Vector2(200, 200),
          position: node.position,
          anchor: Anchor.center,
        );

  @override
  Future onLoad() async {
    add(
      TextComponent(
        text: node.id,
        anchor: Anchor.center,
        position: size / 2,
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: size.x / 3,
            color: Palette.grey,
          ),
        ),
      ),
    );
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
