import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/priority.dart';

class LaneComponent extends PositionComponent with TapCallbacks {
  final Lane lane;
  final Player player;

  LaneComponent({
    required this.lane,
    required this.player,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.topLeft,
          priority: Priority.battlefield.value,
        );

  @override
  void onTapUp(TapUpEvent event) {
    if (player.hasCreditsSelected) {
      spawnUnitOfPlayer(player);
    }
  }

  void spawnUnitOfPlayer(Player player) {
    final int power = player.creditsSelected;
    GameState.instance.onSpawnUnit(
      lane: lane,
      player: player,
      node: lane.nodes[0],
      power: power,
    );
    player.spendCredits(power);
  }
}
