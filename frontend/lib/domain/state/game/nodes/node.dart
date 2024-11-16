import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/accumulator.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/ownership.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

abstract class Node extends Ownership with Accumulator {
  final String id;
  final Lane lane;
  final Vector2 position;
  final double maxNodeSize;

  Node({
    required this.id,
    required this.lane,
    required super.captureRate,
    required this.position,
    required this.maxNodeSize,
  });

  GameState get state => GameState.instance;

  NodeComponent get component;

  Vector2 get size => Vector2(maxNodeSize, maxNodeSize);

  void onTapped() {}

  void spawnUnitOfPlayer(Player player) {
    final int power = player.creditsSelected;
    spawnUnit(power);
    player.spendCredits(power);
  }

  void spawnUnit(int power) => GameState.instance.onSpawnUnit(
        lane: lane,
        player: owner!,
        node: this,
        power: power,
      );
}
