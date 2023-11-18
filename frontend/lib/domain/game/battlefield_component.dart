import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';

class BattlefieldComponent extends SpriteComponent {
  final GameState state;
  final Battlefield battlefield;

  BattlefieldComponent({
    required this.state,
    required this.battlefield,
  }) : super(
          position: Vector2(0, 0),
          sprite: battlefield.sprite,
          size: battlefield.sprite.image.size,
          anchor: Anchor.topLeft,
          priority: -1,
        );

  @override
  FutureOr onLoad() {
    for (final Lane lane in battlefield.lanes) {
      add(LaneListener(
        state: state,
        lane: lane,
      ));
    }

    return super.onLoad();
  }
}

class LaneListener extends PositionComponent with TapCallbacks {
  final GameState state;
  final Lane lane;

  LaneListener({
    required this.state,
    required this.lane,
  }) : super(
          position: lane.position,
          size: lane.size,
          anchor: Anchor.topLeft,
        );

  /*@override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        size.x,
        size.y,
      ),
      BasicPalette.yellow.withAlpha(120).paint(),
    );
  }*/

  @override
  void onTapUp(TapUpEvent event) => state.onLaneSelected(lane);
}
