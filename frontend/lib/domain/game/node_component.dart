import 'dart:async';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeComponent extends PositionComponent with CollisionCallbacks {
  final GameState state;
  final Node node;
  String? owner;
  Paint paint = Paint();

  NodeComponent({
    required this.state,
    required this.node,
  }) : super(
          size: Constants.NODE_SIZE,
          position: node.position,
          anchor: Anchor.center,
          priority: Priority.nodes.value,
        );

  @override
  Future onLoad() async {
    paint.color = Palette.grey;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.stroke;

    print('${node.id} $position');

    add(CircleHitbox(
      radius: size.x / 2,
      position: size / 2,
      anchor: Anchor.center,
    ));

    super.onLoad();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is UnitComponent) {
      owner = other.unit.owner;

      if (owner == Constants.PLAYER_SELF) {
        paint.color = Palette.blue;
      } else {
        paint.color = Palette.red;
      }
    }

    super.onCollisionEnd(other);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      (size / 2).toOffset(),
      Constants.NODE_SIZE.x / 2,
      paint,
    );
  }
}
