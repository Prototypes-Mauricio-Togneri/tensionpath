import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/sprites.dart';

class Player {
  final String id;
  final int ownershipDirection;
  double _credits = 0;
  double _creditsExtraRate = 0;
  int _creditsSelected = 0;

  static final Player SELF = Player._(Constants.PLAYER_SELF, 1);
  static final Player ENEMY = Player._(Constants.PLAYER_ENEMY, -1);

  Player._(this.id, this.ownershipDirection);

  double get credits => _credits;

  double get creditsRate => Constants.CREDITS_RATE + _creditsExtraRate;

  int get creditsSelected => _creditsSelected;

  bool get hasCreditsSelected => _creditsSelected > 0;

  bool get isSelf => id == Constants.PLAYER_SELF;

  bool get isEnemy => id == Constants.PLAYER_ENEMY;

  Color get color => isSelf ? Palette.blue : Palette.red;

  Sprite get unitSprite => isSelf ? Sprites.UNIT_SELF : Sprites.UNIT_ENEMY;

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

  void selectCredits(int value) {
    if (_creditsSelected != value) {
      _creditsSelected = value;
    } else {
      _creditsSelected = 0;
    }
  }

  @override
  bool operator ==(Object other) => other is Player && (id == other.id);

  @override
  int get hashCode => id.hashCode;
}
