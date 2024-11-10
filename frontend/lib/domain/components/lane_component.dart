import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';

class LaneComponent extends PositionComponent with TapCallbacks {
  final Lane lane;
  final Player player;
  Paint? tappedPaint;

  LaneComponent({
    required this.lane,
    required this.player,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.topLeft,
          priority: Priority.lane.value,
        );

  @override
  void onTapDown(TapDownEvent event) {
    if (player.hasCreditsSelected) {
      tappedPaint = Paint();
      tappedPaint!.color = const Color(0x11ffffff);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (player.hasCreditsSelected) {
      tappedPaint = null;
      spawnUnitOfPlayer(player);
    }
  }

  void spawnUnitOfPlayer(Player player) {
    final int power = player.creditsSelected;
    GameState.instance.onSpawnUnit(
      lane: lane,
      player: player,
      node: lane.nodes.first,
      power: power,
    );
    player.spendCredits(power);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (tappedPaint != null) {
      canvas.drawRect(
        size.toRect(),
        tappedPaint!,
      );
    }
  }
}
