import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';
import 'package:tensionpath/domain/types/priority.dart';

class LaneComponent extends PositionComponent {
  final GameState state;
  final Lane lane;

  LaneComponent({
    required this.state,
    required this.lane,
  }) : super(
          priority: Priority.lanes.value,
        );

  @override
  FutureOr onLoad() {
    add(LaneLauncherComponent(
      state: state,
      lane: lane,
      waypoint: lane.waypoints.first,
      owner: Player.SELF,
    ));

    add(LaneLauncherComponent(
      state: state,
      lane: lane,
      waypoint: lane.waypoints.last,
      owner: Player.ENEMY,
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
  final Waypoint waypoint;
  final Player owner;

  LaneLauncherComponent({
    required this.state,
    required this.lane,
    required this.waypoint,
    required this.owner,
  }) : super(
          position: waypoint.position,
          size: Constants.NODE_SIZE,
          anchor: Anchor.center,
          priority: Priority.lanes.value,
        );

  @override
  FutureOr onLoad() {
    add(CircleHitbox(
      radius: size.x / 2,
      position: size / 2,
      anchor: Anchor.center,
    ));

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    state.onLaneSpawnUnit(
      lane: lane,
      owner: owner,
      power: Random().nextInt(10) + 1,
    );
  }

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
