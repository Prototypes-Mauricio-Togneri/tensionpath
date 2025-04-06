import 'dart:ui';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final String name;
  final bool isSelf;
  int resources;
  int resourcesRate;

  Player({
    required this.id,
    required this.name,
    required this.isSelf,
    required this.resources,
    required this.resourcesRate,
  });

  int get resourceRate => resourcesRate;

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

  void replaceWith(Player player) {
    resources = player.resources;
    resourcesRate = player.resourcesRate;
  }

  JsonPlayer toJson() => JsonPlayer(
    id: id,
    name: name,
    resources: resources,
    resourcesRate: resourcesRate,
  );

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
}
