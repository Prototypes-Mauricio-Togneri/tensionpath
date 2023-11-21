import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/types/priority.dart';

class LaneComponent extends PositionComponent with TapCallbacks {
  final GameState state;
  final Lane lane;

  LaneComponent({
    required this.state,
    required this.lane,
  }) : super(
          position: lane.position,
          size: lane.size,
          anchor: Anchor.topLeft,
          priority: Priority.lanes.value,
        );

  @override
  void onTapUp(TapUpEvent event) => state.onLaneSelected(lane);

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
