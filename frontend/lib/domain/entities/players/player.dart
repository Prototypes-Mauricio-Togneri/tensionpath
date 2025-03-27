import 'dart:ui';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/players/active_player.dart';
import 'package:tensionpath/domain/entities/players/self_player.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final double baseResourceRate;
  double resources = Constants.INITIAL_RESOURCES;

  static Player self() =>
      SelfPlayer(id: 'self', baseResourceRate: Constants.RESOUCES_RATE);

  static Player enemy() =>
      ActivePlayer(id: 'enemy', baseResourceRate: Constants.RESOUCES_RATE * 2);

  Player({required this.id, required this.baseResourceRate});

  double get resourceRate => baseResourceRate;

  bool get isSelf => this is SelfPlayer;

  bool get isEnemy => !isSelf;

  Color get color => isSelf ? Palette.PLAYER_SELF : Palette.PLAYER_ENEMY;

  void addResources(double value) {
    resources += value;
    resources = resources.clamp(0, 10);
  }

  bool hasResources(int value) => resources >= value;

  void spendResources(int value) {
    resources -= value;
  }

  @override
  bool operator ==(Object other) => other is Player && (id == other.id);

  @override
  int get hashCode => id.hashCode;

  void update(double dt) {
    takeAction();
  }

  void takeAction() {}
}
