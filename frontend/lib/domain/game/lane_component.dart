import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';

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
        );

  @override
  void onTapUp(TapUpEvent event) => state.onLaneSelected(lane);
}
