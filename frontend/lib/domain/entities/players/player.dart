import 'dart:ui';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final String name;
  final bool isSelf;
  int resources;
  int baseResourceRate;

  Player({
    required this.id,
    required this.name,
    required this.isSelf,
    required this.resources,
    required this.baseResourceRate,
  });

  int get resourceRate => baseResourceRate;

  bool get isOpponent => !isSelf;

  Color get color => isSelf ? Palette.PLAYER_SELF : Palette.PLAYER_OPPONENT;

  void addResources(int value) {
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
