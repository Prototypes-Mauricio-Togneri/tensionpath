import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/sprites.dart';

class Player {
  final String id;
  double commandPoints = 0;
  double commandPointsExtraRatio = 0;

  static final Player SELF = Player._(Constants.PLAYER_SELF);
  static final Player ENEMY = Player._(Constants.PLAYER_ENEMY);

  Player._(this.id);

  double get commandPointsRatio =>
      Constants.COMMAND_POINTS_RATIO + commandPointsExtraRatio;

  bool get isSelf => id == Constants.PLAYER_SELF;

  bool get isEnemy => id == Constants.PLAYER_ENEMY;

  Color get color => isSelf ? Palette.blue : Palette.red;

  Sprite get unitSprite => isSelf ? Sprites.UNIT_SELF : Sprites.UNIT_ENEMY;

  @override
  bool operator ==(Object other) => other is Player && (id == other.id);

  @override
  int get hashCode => id.hashCode;
}
