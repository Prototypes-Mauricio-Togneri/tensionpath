import 'package:tensionpath/domain/json/models/start/json_player.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/utils/map_list.dart';

class Player {
  final String id;
  final String name;
  final String index;
  final int baseMaxHealth;
  int baseHealth;
  double resources;

  Player({
    required this.id,
    required this.name,
    required this.index,
    required this.baseMaxHealth,
    required this.baseHealth,
    required this.resources,
  });

  void removeResources(double amount) {
    if (resources >= amount) {
      resources -= amount;
    }
  }

  factory Player.fromJson(JsonPlayer json) {
    return Player(
      id: json.id,
      name: json.name,
      index: json.index,
      baseMaxHealth: json.baseMaxHealth,
      baseHealth: json.baseHealth,
      resources: json.resources,
    );
  }

  static MapList<String, Player> list(List<JsonPlayer> json) {
    final MapList<String, Player> result = MapList();

    for (final JsonPlayer jsonPlayer in json) {
      final Player player = Player.fromJson(jsonPlayer);
      result.add(jsonPlayer.id, player);
    }

    return result;
  }

  JsonPlayerUpdate toJsonUpdate() => JsonPlayerUpdate(
    baseHealth: baseHealth,
    resources: resources,
  );
}
