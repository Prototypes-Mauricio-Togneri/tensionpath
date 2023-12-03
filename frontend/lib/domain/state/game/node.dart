import 'dart:math';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/ownership.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/utils/sprites.dart';

class Node {
  final String id;
  final Vector2 position;
  final NodeType type;
  late final Ownership ownership;
  late GameState state;
  double _creditsAccumulated = 0;

  Node({
    required this.id,
    required this.position,
    required this.type,
    Player? owner,
  }) {
    ownership = Ownership.create(
      node: this,
      rate: type.rate,
      owner: owner,
    );
  }

  Sprite get sprite {
    if (owner == null) {
      return Sprites.NODE_NEUTRAL;
    } else {
      if (type.isLauncher) {
        if (owner!.isEnemy) {
          return Sprites.LAUNCHER_ENEMY;
        } else if (owner!.isSelf) {
          return Sprites.LAUNCHER_SELF;
        }
      } else {
        if (owner!.isEnemy) {
          return Sprites.NODE_ENEMY;
        } else if (owner!.isSelf) {
          return Sprites.NODE_SELF;
        }
      }
    }

    throw Exception('Cannot determine node sprite');
  }

  bool get hasOwner => ownership.hasOwner;

  Player? get owner => ownership.owner;

  bool get hasCreditsAccumulated => creditsAccumulated > 0;

  double get creditsAccumulated => _creditsAccumulated.floorToDouble();

  void setGameState(GameState gameState) {
    state = gameState;
  }

  void onTouched(Player player) => ownership.touched(player);

  void onUnitCollidedWithBase(Unit unit) => state.onUnitCollidedWithBase(
        unit: unit,
        baseOwner: owner!,
      );

  void onSpawnUnit() => state.onNodeSpawnUnit(
        node: this,
        power: Random().nextInt(10) + 1,
      );

  void onChestAcquired(Player player) {
    state.onAddCredits(
      player: player,
      credits: creditsAccumulated,
    );

    resetCreditsAccumulated();
  }

  void onNewOwner({
    required Player? previousOwner,
    required Player newOwner,
  }) {
    _creditsAccumulated = 0;

    if (type.isVictory) {
      state.onNodeVictoryCaptured(this);
    } else if (type.isCreditsGenerator) {
      state.onNodeCreditsGeneratorCaptured(
        node: this,
        previousOwner: previousOwner,
        newOwner: newOwner,
      );
    }
  }

  void resetCreditsAccumulated() {
    _creditsAccumulated = 0;
  }

  bool update(double dt) {
    if (type.canAccumulate) {
      if (type.isChest || (hasOwner && (type.isUnitGenerator))) {
        _creditsAccumulated += Constants.NODE_CREDITS_RATIO * dt;
      }

      if (hasOwner && (type.isUnitGenerator) && (_creditsAccumulated >= 1)) {
        _creditsAccumulated -= 1;
        state.onNodeSpawnUnit(
          node: this,
          power: 1,
        );
      }
    }

    return ownership.update(dt);
  }
}
