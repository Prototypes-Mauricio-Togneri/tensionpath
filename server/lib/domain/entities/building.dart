import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/start/json_building_start.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Building {
  final BuildingType type;
  final Player player;
  final Location location;
  final Position position;
  final num radius;
  bool isUnlocked = false;

  Building({
    required this.type,
    required this.player,
    required this.location,
    required this.position,
    required this.radius,
  });

  String get id => location.id;

  JsonEvent unlock() {
    isUnlocked = true;

    return JsonEvent.buildingUnlocked(
      playerIndex: player.index,
      buildingType: type,
    );
  }

  factory Building.fromJson({
    required JsonBuildingStart json,
    required Player player,
    required num radius,
  }) => Building(
    type: json.type,
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
    type: type,
    playerIndex: player.index,
    location: location.toJson(),
    position: position.toJson(),
  );
}
