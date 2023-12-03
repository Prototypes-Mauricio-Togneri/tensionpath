import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/nodes/node_accumulator.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeChest extends Node with NodeAccumulator {
  NodeChest({
    required super.id,
    required super.position,
    super.owner,
  }) : super(rate: Constants.NODE_CHEST_CAPTURE_RATE);

  @override
  Sprite get sprite => Sprites.NODE_NEUTRAL;

  void onAcquired(Player player) {
    state.onAddCredits(
      player: player,
      credits: creditsAccumulated,
    );

    reset();
  }

  @override
  bool update(double dt) {
    accumulate(dt);

    return super.update(dt);
  }
}
