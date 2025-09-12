import 'package:tensionpath/domain/json/models/start/json_player.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';

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

  JsonPlayerUpdate toJsonUpdate() => JsonPlayerUpdate(
    baseHealth: baseHealth,
    resources: resources,
  );
}
