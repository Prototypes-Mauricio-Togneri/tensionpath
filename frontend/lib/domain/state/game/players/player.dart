import 'dart:ui';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/players/active_player.dart';
import 'package:tensionpath/domain/state/game/players/self_player.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final int ownershipDirection;
  double credits = 0;
  double creditsExtraRate = 0;
  int creditsSelected = 0;

  static final Player SELF = SelfPlayer(
    id: Constants.PLAYER_SELF,
    ownershipDirection: 1,
  );

  static final Player ENEMY = ActivePlayer(
    id: Constants.PLAYER_ENEMY,
    ownershipDirection: -1,
  );

  Player({
    required this.id,
    required this.ownershipDirection,
  });

  double get creditsRate => Constants.CREDITS_RATE + creditsExtraRate;

  bool get hasCreditsSelected => creditsSelected > 0;

  bool get isSelf => this is SelfPlayer;

  bool get isEnemy => !isSelf;

  Color get color => isSelf ? Palette.blue : Palette.red;

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
    creditsSelected = 0;
    credits -= value;
  }

  void selectCredits(int value) {
    if (creditsSelected != value) {
      creditsSelected = value;
    } else {
      creditsSelected = 0;
    }
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
