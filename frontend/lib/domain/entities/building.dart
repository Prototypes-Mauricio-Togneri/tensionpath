import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_building_start.dart';
import 'package:tensionpath/domain/types/building_type.dart';

class Building {
  final Player player;
  final Location location;
  final Position position;
  final BuildingType type;
  late bool isUnlocked;

  Building({
    required this.player,
    required this.location,
    required this.position,
    required this.type,
  }) {
    isUnlocked = type == BuildingType.main;
  }

  void unlock() {
    isUnlocked = true;
  }

  factory Building.fromJson({
    required JsonBuildingStart json,
    required Player player,
  }) => Building(
    player: player,
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    type: json.type,
  );

  static List<Building> list({
    required List<JsonBuildingStart> json,
    required List<Player> players,
  }) {
    final List<Building> result = [];

    for (final JsonBuildingStart jsonBuilding in json) {
      final Player player = players.firstWhere(
        (player) => player.index == jsonBuilding.playerIndex,
      );

      final Building building = Building.fromJson(
        json: jsonBuilding,
        player: player,
      );
      result.add(building);
    }

    return result;
  }
}
