import 'dart:ui';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/utils/palette.dart';

class Player {
  final String id;
  final String name;
  final bool isSelf;
  late int _resources;
  late int _resourcesRate;

  Player({
    required this.id,
    required this.name,
    required this.isSelf,
    required int resources,
    required int resourcesRate,
  }) {
    _resources = resources;
    _resourcesRate = resourcesRate;
  }

  int get resources => _resources;

  int get resourcesRate => _resourcesRate;

  bool get isPlayer1 => id == '1';

  bool get isPlayer2 => id == '2';

  bool get isOpponent => !isSelf;

  Color get color => isPlayer1 ? Palette.PLAYER_1 : Palette.PLAYER_2;

  bool hasResources(int value) => resources >= value;

  void spendResources(int value) {
    _resources -= value;
  }

  void replaceWith(Player newPlayer) {
    _resources = newPlayer.resources;
    _resourcesRate = newPlayer.resourcesRate;
  }

  JsonPlayer addResources(int amount) => JsonPlayer(
    id: id,
    name: name,
    resources: resources + amount,
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
