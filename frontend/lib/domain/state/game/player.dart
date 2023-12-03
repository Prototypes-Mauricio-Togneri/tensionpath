import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/sprites.dart';

class Player {
  final String id;
  final int ownershipDirection;
  double _credits = 0;
  double _creditsExtraRatio = 0;

  static final Player SELF = Player._(Constants.PLAYER_SELF, 1);
  static final Player ENEMY = Player._(Constants.PLAYER_ENEMY, -1);

  Player._(this.id, this.ownershipDirection);

  double get credits => _credits;

  double get creditsRatio => Constants.CREDITS_RATIO + _creditsExtraRatio;

  bool get isSelf => id == Constants.PLAYER_SELF;

  bool get isEnemy => id == Constants.PLAYER_ENEMY;

  Color get color => isSelf ? Palette.blue : Palette.red;

  Sprite get unitSprite => isSelf ? Sprites.UNIT_SELF : Sprites.UNIT_ENEMY;

  void update(double dt) {
    _credits += creditsRatio * dt;
  }

  void addCreditsExtraRatio(double value) {
    _creditsExtraRatio += value;
  }

  void removeCreditsExtraRatio(double value) {
    _creditsExtraRatio -= value;
  }

  void addCredits(double value) {
    _credits += value;
  }

  @override
  bool operator ==(Object other) => other is Player && (id == other.id);

  @override
  int get hashCode => id.hashCode;
}
