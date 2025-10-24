import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/start/json_player_start.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Player {
  final String id;
  final String name;
  final String index;
  final num baseMaxHealth;
  final num resourcesPassiveRate;
  final num resourcesActiveRate;
  final List<UnitType> deck;
  final List<BuildingType> buildings = [];
  num baseHealth;
  num resources;

  Player({
    required this.id,
    required this.name,
    required this.index,
    required this.baseMaxHealth,
    required this.baseHealth,
    required this.resources,
    required this.resourcesPassiveRate,
    required this.resourcesActiveRate,
    required this.deck,
  }) {
    if (deck.contains(UnitType.harvester)) {
      buildings.add(BuildingType.refinery);
    }
  }

  bool get isAlive => baseHealth > 0;

  void removeHealth(num amount) {
    baseHealth -= amount;

    if (baseHealth < 0) {
      baseHealth = 0;
    }
  }

  void surrender() {
    baseHealth = 0;
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

  bool hasBuildingLocked(BuildingType type) => !buildings.contains(type);

  JsonEvent unlockBuilding(BuildingType type) {
    buildings.add(type);

    return JsonEvent.buildingUnlocked(
      playerIndex: index,
      buildingType: type,
    );
  }

  factory Player.fromJson(JsonPlayerStart json) => Player(
    id: json.id,
    name: json.name,
    index: json.index,
    baseMaxHealth: json.baseMaxHealth,
    baseHealth: json.baseHealth,
    resources: json.resources,
    resourcesPassiveRate: json.resourcesPassiveRate,
    resourcesActiveRate: json.resourcesActiveRate,
    deck: json.deck,
  );

  static IterableMap<String, Player> list(List<JsonPlayerStart> json) {
    final IterableMap<String, Player> result = IterableMap();

    for (final JsonPlayerStart jsonPlayer in json) {
      final Player player = Player.fromJson(jsonPlayer);
      result.add(player.index, player);
    }

    return result;
  }

  JsonPlayerStart toJson(bool isSelf) => JsonPlayerStart(
    id: id,
    name: name,
    isSelf: isSelf,
    index: index,
    baseHealth: baseHealth,
    baseMaxHealth: baseMaxHealth,
    resources: resources,
    resourcesPassiveRate: resourcesPassiveRate,
    resourcesActiveRate: resourcesActiveRate,
    deck: deck,
  );

  @override
  bool operator ==(Object other) => other is Player && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
