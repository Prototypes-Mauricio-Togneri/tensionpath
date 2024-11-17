import 'dart:ui';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';
import 'package:tensionpath/domain/state/game/players/active_player.dart';
import 'package:tensionpath/domain/state/game/players/self_player.dart';
import 'package:tensionpath/utils/palette.dart';

class Player with GameEngineRef {
  final String id;
  final int ownershipDirection;
  double credits = 0;
  double creditsExtraRate = 0;

  static Player self() => SelfPlayer(
        id: 'self',
        ownershipDirection: 1,
      );

  static Player enemy() => ActivePlayer(
        id: 'enemy',
        ownershipDirection: -1,
      );

  Player({
    required this.id,
    required this.ownershipDirection,
  });

  double get creditsRate => Constants.CREDITS_RATE + creditsExtraRate;

  bool get isSelf => this is SelfPlayer;

  bool get isEnemy => !isSelf;

  Color get color => isSelf ? Palette.PLAYER_SELF : Palette.PLAYER_ENEMY;

  void addCreditsExtraRate(double value) {
    creditsExtraRate += value;
  }

  void removeCreditsExtraRate(double value) {
    creditsExtraRate -= value;
  }

  void addCredits(double value) {
    credits += value;
    credits = credits.clamp(0, 10);
  }

  void spendCredits(int value) {
    credits -= value;
  }

  @override
  bool operator ==(Object other) => other is Player && (id == other.id);

  @override
  int get hashCode => id.hashCode;

  void update(double dt) {
    credits += creditsRate * dt;
    credits = credits.clamp(0, 10);

    takeAction();
  }

  void takeAction() {}
}
