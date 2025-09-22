import 'dart:ui';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/update.dart';
import 'package:tensionpath/domain/json/models/start/json_player_start.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final String name;
  final String index;
  final bool isSelf;
  final num baseMaxHealth;
  num baseHealth;
  num resources;
  num resourcesRate;
  Player({
    required this.id,
    required this.name,
    required this.index,
    required this.isSelf,
    required this.baseMaxHealth,
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
  });

  bool get isOpponent => !isSelf;

  bool get isPlayer1 => index == Constants.PLAYER_1;

  bool get isPlayer2 => index == Constants.PLAYER_2;

  Color get color => isPlayer1 ? Palette.PLAYER_1 : Palette.PLAYER_2;

  void update(PlayerUpdate player) {
    baseHealth = player.baseHealth;
    resources = player.resources;
    resourcesRate = player.resourcesRate;
  }

  void addResources(double value) {
    resources += value;
  }

  factory Player.fromJson(JsonPlayerStart player) => Player(
    id: player.id,
    index: player.index,
    isSelf: player.isSelf,
    name: player.name,
    baseMaxHealth: player.baseMaxHealth,
    baseHealth: player.baseHealth,
    resources: player.resources,
    resourcesRate: player.resourcesRateBase,
  );
}
