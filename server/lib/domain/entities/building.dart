import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_building_start.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Building {
  final Player player;
  final Location location;
  final Position position;
  final num radius;

  const Building({
    required this.player,
    required this.location,
    required this.position,
    required this.radius,
  });

  String get id => location.id;

  factory Building.fromJson({
    required JsonBuildingStart json,
    required Player player,
    required num radius,
  }) => Building(
    player: player,
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    radius: radius,
  );

  static IterableMap<String, Building> list({
    required List<JsonBuildingStart> json,
    required Players players,
    required num radius,
  }) {
    final IterableMap<String, Building> result = IterableMap();

    for (final JsonBuildingStart jsonBuilding in json) {
      final Building building = Building.fromJson(
        json: jsonBuilding,
        player: players.get(jsonBuilding.playerIndex),
        radius: radius,
      );
      result.add(building.location.id, building);
    }

    return result;
  }

  JsonBuildingStart toJson() => JsonBuildingStart(
    playerIndex: player.index,
    location: location.toJson(),
    position: position.toJson(),
  );
}
