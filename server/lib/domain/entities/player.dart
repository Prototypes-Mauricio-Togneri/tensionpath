import 'package:tensionpath/domain/json/models/start/json_player_start.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Player {
  final String id;
  final String name;
  final String index;
  final num baseMaxHealth;
  final num resourcesRateBase;
  num baseHealth;
  num resources;
  num resourcesRate;

  Player({
    required this.id,
    required this.name,
    required this.index,
    required this.baseMaxHealth,
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
    required this.resourcesRateBase,
  });

  void increaseResourcesRate() {
    resourcesRate += resourcesRateBase;
  }

  void addResources(num amount) {
    resources += amount;
  }

  bool removeResources(num amount) {
    if (resources >= amount) {
      resources -= amount;
      return true;
    } else {
      return false;
    }
  }

  factory Player.fromJson(JsonPlayerStart json) {
    return Player(
      id: json.id,
      name: json.name,
      index: json.index,
      baseMaxHealth: json.baseMaxHealth,
      baseHealth: json.baseHealth,
      resources: json.resources,
      resourcesRate: json.resourcesRateBase,
      resourcesRateBase: json.resourcesRateBase,
    );
  }

  static IterableMap<String, Player> list(List<JsonPlayerStart> json) {
    final IterableMap<String, Player> result = IterableMap();

    for (final JsonPlayerStart jsonPlayer in json) {
      final Player player = Player.fromJson(jsonPlayer);
      result.add(player.index, player);
    }

    return result;
  }

  JsonPlayerUpdate toJsonUpdate() => JsonPlayerUpdate(
    baseHealth: baseHealth.ceil(),
    resources: resources.floor(),
    resourcesRate: resourcesRate,
  );

  JsonPlayerStart toJson(bool isSelf) => JsonPlayerStart(
    id: id,
    name: name,
    isSelf: isSelf,
    index: index,
    baseHealth: baseHealth,
    baseMaxHealth: baseMaxHealth,
    resources: resources,
    resourcesRateBase: resourcesRateBase,
  );

  @override
  bool operator ==(Object other) => other is Player && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
