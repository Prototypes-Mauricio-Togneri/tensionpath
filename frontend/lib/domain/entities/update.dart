import 'package:tensionpath/domain/entities/event.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class MatchUpdate {
  final MatchStatus status;
  final Map<String, UnitUpdate> units;
  final String? winner;
  final List<Event> events;

  const MatchUpdate({
    required this.status,
    required this.units,
    required this.winner,
    required this.events,
  });

  factory MatchUpdate.fromJson(JsonMatchUpdate json) => MatchUpdate(
    status: json.status,
    units: json.units.map(
      (key, value) => MapEntry(key, UnitUpdate.fromJson(value)),
    ),
    winner: null,
    events: json.events.map(Event.fromJson).toList(),
  );
}

class PlayerUpdate {
  final int baseHealth;
  final int resources;
  final num resourcesRate;
  final int currentHarvesterCount;

  const PlayerUpdate({
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
    required this.currentHarvesterCount,
  });

  factory PlayerUpdate.fromJson(JsonPlayerUpdate json) => PlayerUpdate(
    baseHealth: json.baseHealth,
    resources: json.resources,
    resourcesRate: json.resourcesRate,
    currentHarvesterCount: json.currentHarvesterCount,
  );
}

class UnitUpdate {
  final String id;
  final String playerIndex;
  final UnitType type;
  final num health;
  final num maxHealth;
  final Position currentPosition;
  final Position? targetPosition;
  final Location? lockedLocation;
  final Location? targetBase;
  final String? targetUnitId;

  const UnitUpdate({
    required this.id,
    required this.playerIndex,
    required this.type,
    required this.health,
    required this.maxHealth,
    required this.currentPosition,
    required this.targetPosition,
    required this.lockedLocation,
    required this.targetBase,
    required this.targetUnitId,
  });

  factory UnitUpdate.fromJson(JsonUnitUpdate json) => UnitUpdate(
    id: json.id,
    playerIndex: json.playerIndex,
    type: json.type,
    health: json.health,
    maxHealth: json.maxHealth,
    currentPosition: Position.fromJson(json.currentPosition),
    targetPosition: json.targetPosition != null
        ? Position.fromJson(json.targetPosition!)
        : null,
    lockedLocation: json.lockedLocation != null
        ? Location.fromJson(json.lockedLocation!)
        : null,
    targetBase: json.targetBase != null
        ? Location.fromJson(json.targetBase!)
        : null,
    targetUnitId: json.targetUnitId,
  );
}
