import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/ownership.dart';
import 'package:tensionpath/domain/state/game/player.dart';

abstract class Node {
  final String id;
  final Vector2 position;
  late final Ownership ownership;
  late GameState state;

  Node({
    required this.id,
    required this.position,
    required double rate,
    Player? owner,
  }) {
    ownership = Ownership.create(
      node: this,
      rate: rate,
      owner: owner,
    );
  }

  Sprite get sprite;

  bool get hasOwner => ownership.hasOwner;

  Player? get owner => ownership.owner;

  void setGameState(GameState gameState) {
    state = gameState;
  }

  void spawnUnit(int power) => state.onNodeSpawnUnit(node: this, power: power);

  void onNewOwner({
    required Player? previousOwner,
    required Player newOwner,
  }) {}

  bool update(double dt) => ownership.update(dt);
}
