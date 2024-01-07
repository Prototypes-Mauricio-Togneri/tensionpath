import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/ownership.dart';
import 'package:tensionpath/domain/state/game/player.dart';

abstract class Node {
  final String id;
  final Vector2 position;
  late final Ownership ownership;

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

  void spawnUnitOfPlayer(Player player) {
    final int power = player.creditsSelected;
    spawnUnit(power);
    player.spendCredits(power);
  }

  void spawnUnit(int power) {
    GameState.instance.onNodeSpawnUnit(
      node: this,
      power: power,
    );
  }

  void onOwnerAssigned(Player owner) {}

  void onOwnerUnassigned(Player owner) {}

  @mustCallSuper
  bool update(double dt) => ownership.update(dt);
}
