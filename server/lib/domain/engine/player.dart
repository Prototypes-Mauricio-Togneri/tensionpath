import 'package:tensionpath/domain/json/models/start/json_player.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/utils/map_list.dart';

class Player {
  final String name;
  final String index;
  final int baseMaxHealth;
  final double resourcesRateBase;
  int baseHealth;
  double resources;
  double resourcesRate;

  Player({
    required this.name,
    required this.index,
    required this.baseMaxHealth,
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
    required this.resourcesRateBase,
  });

  void removeResources(double amount) {
    if (resources >= amount) {
      resources -= amount;
    }
  }

  factory Player.fromJson(JsonPlayer json) {
    return Player(
      name: json.name,
      index: json.index,
      baseMaxHealth: json.baseMaxHealth,
      baseHealth: json.baseHealth,
      resources: json.resources,
      resourcesRate: json.resourcesRateBase,
      resourcesRateBase: json.resourcesRateBase,
    );
  }

  static MapList<String, Player> list(List<JsonPlayer> json) {
    final MapList<String, Player> result = MapList();

    for (final JsonPlayer jsonPlayer in json) {
      final Player player = Player.fromJson(jsonPlayer);
      result.add(player.index, player);
    }

    return result;
  }

  JsonPlayerUpdate toJsonUpdate() => JsonPlayerUpdate(
    baseHealth: baseHealth,
    resources: resources,
    resourcesRate: resourcesRate,
  );
}
