import 'dart:ui';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/game/json_player.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final bool isSelf;
  final String name;
  final int baseMaxHealth;
  int baseHealth;
  double resources;

  Player({
    required this.id,
    required this.isSelf,
    required this.name,
    required this.baseMaxHealth,
    required this.baseHealth,
    required this.resources,
  });

  bool get isOpponent => !isSelf;

  bool get isPlayer1 => id == Constants.PLAYER_1;

  bool get isPlayer2 => id == Constants.PLAYER_2;

  Color get color => isPlayer1 ? Palette.PLAYER_1 : Palette.PLAYER_2;

  void update(JsonPlayer player) {
    baseHealth = player.baseHealth;
    resources = player.resources;
  }

  void addResources(double value) {
    resources += value;
  }

  void removeResources(int value) {
    resources -= value;
  }

  factory Player.fromJson(JsonPlayer player) => Player(
    id: player.id,
    isSelf: player.isSelf,
    name: player.name,
    baseMaxHealth: player.baseMaxHealth,
    baseHealth: player.baseHealth,
    resources: player.resources,
  );
}
