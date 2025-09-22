import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class MatchUpdate {
  final Map<String, PlayerUpdate> players;
  final MissileUpdate missile;
  final Map<String, num> resources;
  final Map<String, UnitUpdate> units;

  const MatchUpdate({
    required this.players,
    required this.missile,
    required this.resources,
    required this.units,
  });

  factory MatchUpdate.fromJson(JsonMatchUpdate json) => MatchUpdate(
    players: json.players.map(
      (key, value) => MapEntry(key, PlayerUpdate.fromJson(value)),
    ),
    missile: MissileUpdate.fromJson(json.missile),
    resources: Map<String, num>.from(json.resources),
    units: json.units.map(
      (key, value) => MapEntry(key, UnitUpdate.fromJson(value)),
    ),
  );
}

class PlayerUpdate {
  final int baseHealth;
  final int resources;
  final num resourcesRate;

  const PlayerUpdate({
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
  });

  factory PlayerUpdate.fromJson(JsonPlayerUpdate json) => PlayerUpdate(
    baseHealth: json.baseHealth,
    resources: json.resources,
    resourcesRate: json.resourcesRate,
  );
}

class MissileUpdate {
  final num charge;
  final String? owner;
  final Map<String, String?> platforms;

  const MissileUpdate({
    required this.charge,
    required this.owner,
    required this.platforms,
  });

  factory MissileUpdate.fromJson(JsonMissileUpdate json) => MissileUpdate(
    charge: json.charge,
    owner: json.owner,
    platforms: Map<String, String?>.from(json.platforms),
  );
}

class UnitUpdate {
  final String id;
  final String playerIndex;
  final UnitType type;
  final num health;
  final Position currentPosition;
  final Position? targetPosition;
  final Location? lockedLocation;

  const UnitUpdate({
    required this.id,
    required this.playerIndex,
    required this.type,
    required this.health,
    required this.currentPosition,
    required this.targetPosition,
    required this.lockedLocation,
  });

  factory UnitUpdate.fromJson(JsonUnitUpdate json) => UnitUpdate(
    id: json.id,
    playerIndex: json.playerIndex,
    type: json.type,
    health: json.health,
    currentPosition: Position.fromJson(json.currentPosition),
    targetPosition: json.targetPosition != null
        ? Position.fromJson(json.targetPosition!)
        : null,
    lockedLocation: json.lockedLocation != null
        ? Location.fromJson(json.lockedLocation!)
        : null,
  );
}
