import 'dart:ui';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final String name;
  final bool isSelf;
  late int _baseHealth;
  final int baseMaxHealth;
  late int _resources;

  Player({
    required this.id,
    required this.name,
    required this.isSelf,
    required int baseHealth,
    required this.baseMaxHealth,
    required int resources,
  }) {
    _baseHealth = baseHealth;
    _resources = resources;
  }

  int get baseHealth => _baseHealth;

  int get resources => _resources;

  bool get isPlayer1 => id == Constants.PLAYER_1;

  bool get isPlayer2 => id == Constants.PLAYER_2;

  bool get isOpponent => !isSelf;

  Color get color => isPlayer1 ? Palette.PLAYER_1 : Palette.PLAYER_2;

  bool hasResources(int value) => resources >= value;

  void replaceWith(Player newPlayer) {
    _baseHealth = newPlayer.baseHealth;
    _resources = newPlayer.resources;
  }

  static Player? playerById({
    required String? id,
    required List<Player> players,
  }) {
    if (id != null) {
      for (final Player player in players) {
        if (player.id == id) {
          return player;
        }
      }
    }

    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is! Player) {
      return false;
    } else {
      return other.id == id;
    }
  }

  @override
  int get hashCode => id.toString().hashCode;
}
