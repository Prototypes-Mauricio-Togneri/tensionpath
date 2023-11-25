import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/sprites.dart';

class Player {
  final String id;

  const Player._(this.id);

  bool get isSelf => id == Constants.PLAYER_SELF;

  bool get isEnemy => id == Constants.PLAYER_ENEMY;

  Color get color => isSelf ? Palette.blue : Palette.red;

  Sprite get unitSprite => isSelf ? Sprites.UNIT_SELF : Sprites.UNIT_ENEMY;

  factory Player.self() => const Player._(Constants.PLAYER_SELF);

  factory Player.enemy() => const Player._(Constants.PLAYER_ENEMY);

  @override
  bool operator ==(Object other) => other is Player && (id == other.id);

  @override
  int get hashCode => id.hashCode;
}
