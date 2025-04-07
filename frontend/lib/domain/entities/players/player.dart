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

  bool get isPlayer1 => id == '1';

  bool get isOpponent => !isSelf;

  Color get color => isSelf ? Palette.PLAYER_SELF : Palette.PLAYER_OPPONENT;

  bool hasResources(int value) => resources >= value;

  void spendResources(int value) {
    resources -= value;
  }

  void replaceWith(Player newPlayer) {
    resources = newPlayer.resources;
    resourcesRate = newPlayer.resourcesRate;
  }

  JsonPlayer addResources(int amount) => JsonPlayer(
    id: id,
    name: name,
    resources: resources + amount + resourcesRate,
    resourcesRate: resourcesRate,
  );

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
