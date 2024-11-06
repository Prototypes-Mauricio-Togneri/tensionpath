import 'dart:ui';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final int ownershipDirection;
  double _credits = 0;
  double _creditsExtraRate = 0;
  int _creditsSelected = 0;
  double _hp = 100;

  static final Player SELF = Player._(Constants.PLAYER_SELF, 1);
  static final Player ENEMY = Player._(Constants.PLAYER_ENEMY, -1);

  Player._(this.id, this.ownershipDirection);

  double get credits => _credits;

  double get creditsRate => Constants.CREDITS_RATE + _creditsExtraRate;

  int get creditsSelected => _creditsSelected;

  bool get hasCreditsSelected => _creditsSelected > 0;

  double get hp => _hp;

  bool get isSelf => id == Constants.PLAYER_SELF;

  bool get isEnemy => id == Constants.PLAYER_ENEMY;

  Color get color => isSelf ? Palette.blue : Palette.red;

  void update(double dt) {
    _credits += creditsRate * dt;
    _credits = _credits.clamp(0, 10);
  }

  void addCreditsExtraRate(double value) {
    _creditsExtraRate += value;
  }

  void removeCreditsExtraRate(double value) {
    _creditsExtraRate -= value;
  }

  void addCredits(double value) {
    _credits += value;
    _credits = _credits.clamp(0, 10);
  }

  void spendCredits(int value) {
    _creditsSelected = 0;
    _credits -= value;
  }

  void selectCredits(int value) {
    if (_creditsSelected != value) {
      _creditsSelected = value;
    } else {
      _creditsSelected = 0;
    }
  }

  void reduceHp(int value) {
    _hp -= value;
    _hp = _hp.clamp(0, 100);
  }

  @override
  bool operator ==(Object other) => other is Player && (id == other.id);

  @override
  int get hashCode => id.hashCode;
}
