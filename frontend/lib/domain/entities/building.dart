import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_building_start.dart';

class Building {
  final String playerIndex;
  final Location location;
  final Position position;

  const Building({
    required this.playerIndex,
    required this.location,
    required this.position,
  });

  factory Building.fromJson(JsonBuildingStart json) => Building(
    playerIndex: json.playerIndex,
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
  );

  static List<Building> list(List<JsonBuildingStart> json) {
    final List<Building> result = [];

    for (final JsonBuildingStart jsonBuilding in json) {
      final Building building = Building.fromJson(jsonBuilding);
      result.add(building);
    }

    return result;
  }
}
