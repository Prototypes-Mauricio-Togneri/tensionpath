import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';
import 'package:tensionpath/domain/types/priority.dart';

class LaneComponent extends PositionComponent {
  final GameState state;
  final Lane lane;

  LaneComponent({
    required this.state,
    required this.lane,
  }) : super(
          position: Vector2(0, 0),
          size: state.battlefield.sprite.image.size,
          anchor: Anchor.topLeft,
          priority: Priority.lanes.value,
        );

  @override
  FutureOr onLoad() {
    add(LaneLauncherComponent(
      state: state,
      lane: lane,
    ));

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    if (debugMode) {
      for (final Waypoint waypoint in lane.waypoints) {
        canvas.drawCircle(
          waypoint.position.toOffset(),
          20,
          BasicPalette.green.paint()..style = PaintingStyle.fill,
        );
      }
    }
  }
}

class LaneLauncherComponent extends PositionComponent with TapCallbacks {
  final GameState state;
  final Lane lane;

  LaneLauncherComponent({
    required this.state,
    required this.lane,
  }) : super(
          position: lane.position,
          size: lane.size,
          anchor: Anchor.topLeft,
          priority: Priority.lanes.value,
        );

  @override
  void onTapUp(TapUpEvent event) => state.onLauncherSelected(lane);

  @override
  void render(Canvas canvas) {
    if (debugMode) {
      canvas.drawRect(
        Rect.fromLTWH(
          0,
          0,
          width,
          height,
        ),
        BasicPalette.green.withAlpha(128).paint(),
      );
    }
  }
}
