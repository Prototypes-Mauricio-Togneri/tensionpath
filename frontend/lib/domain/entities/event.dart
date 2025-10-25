import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/events/json_event_base_damaged.dart';
import 'package:tensionpath/domain/json/models/events/json_event_building_unlocked.dart';
import 'package:tensionpath/domain/json/models/events/json_event_match_finished.dart';
import 'package:tensionpath/domain/json/models/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/models/events/json_event_player.dart';
import 'package:tensionpath/domain/json/models/events/json_event_resource_depleted.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_attack.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_created.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_damaged.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_movement_ended.dart';
import 'package:tensionpath/domain/json/models/events/json_event_unit_movement_started.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Event {
  static Event fromJson(JsonEvent json) {
    if (json.missile != null) {
      return EventMissile.fromJson(json.missile!);
    } else if (json.player != null) {
      return EventPlayer.fromJson(json.player!);
    } else if (json.baseDamaged != null) {
      return EventBaseDamaged.fromJson(json.baseDamaged!);
    } else if (json.resourceDepleted != null) {
      return EventResourcesDepleted.fromJson(json.resourceDepleted!);
    } else if (json.buildingUnlocked != null) {
      return EventBuildingUnlocked.fromJson(json.buildingUnlocked!);
    } else if (json.unitCreated != null) {
      return EventUnitCreated.fromJson(json.unitCreated!);
    } else if (json.unitMovementStarted != null) {
      return EventUnitMovementStarted.fromJson(json.unitMovementStarted!);
    } else if (json.unitMovementEnded != null) {
      return EventUnitMovementEnded.fromJson(json.unitMovementEnded!);
    } else if (json.unitAttack != null) {
      return EventUnitAttack.fromJson(json.unitAttack!);
    } else if (json.unitDamaged != null) {
      return EventUnitDamaged.fromJson(json.unitDamaged!);
    } else if (json.matchFinished != null) {
      return EventMatchFinished.fromJson(json.matchFinished!);
    } else {
      throw UnimplementedError('Unknown event type');
    }
  }
}

class EventMissile implements Event {
  final num charge;
  final String? owner;
  final Map<String, String?> platforms;
  final bool fired;

  const EventMissile({
    required this.charge,
    required this.owner,
    required this.platforms,
    required this.fired,
  });

  factory EventMissile.fromJson(JsonEventMissile json) => EventMissile(
    charge: json.charge,
    owner: json.owner,
    platforms: Map<String, String?>.from(json.platforms),
    fired: json.fired,
  );
}

class EventPlayer implements Event {
  final String index;
  final num resources;
  final num resourcesRate;
  final int currentHarvesterCount;
  final int maxHarvestersCount;

  const EventPlayer({
    required this.index,
    required this.resources,
    required this.resourcesRate,
    required this.currentHarvesterCount,
    required this.maxHarvestersCount,
  });

  factory EventPlayer.fromJson(JsonEventPlayer json) => EventPlayer(
    index: json.index,
    resources: json.resources,
    resourcesRate: json.resourcesRate,
    currentHarvesterCount: json.currentHarvesterCount,
    maxHarvestersCount: json.maxHarvestersCount,
  );
}

class EventBaseDamaged implements Event {
  final String playerIndex;
  final num damage;

  const EventBaseDamaged({
    required this.playerIndex,
    required this.damage,
  });

  factory EventBaseDamaged.fromJson(JsonEventBaseDamaged json) =>
      EventBaseDamaged(
        playerIndex: json.playerIndex,
        damage: json.damage,
      );
}

class EventResourcesDepleted implements Event {
  final String id;

  const EventResourcesDepleted({
    required this.id,
  });

  factory EventResourcesDepleted.fromJson(JsonEventResourceDepleted json) =>
      EventResourcesDepleted(id: json.id);
}

class EventBuildingUnlocked implements Event {
  final String playerIndex;
  final BuildingType type;

  const EventBuildingUnlocked({
    required this.playerIndex,
    required this.type,
  });

  factory EventBuildingUnlocked.fromJson(JsonEventBuildingUnlocked json) =>
      EventBuildingUnlocked(
        playerIndex: json.playerIndex,
        type: json.type,
      );
}

class EventUnitCreated implements Event {
  final String id;
  final String playerIndex;
  final UnitType type;
  final num health;
  final Position currentPosition;
  final Position? targetPosition;
  final Location? lockedLocation;
  final Location? targetBase;
  final String? targetUnitId;

  const EventUnitCreated({
    required this.id,
    required this.playerIndex,
    required this.type,
    required this.health,
    required this.currentPosition,
    required this.targetPosition,
    required this.lockedLocation,
    required this.targetBase,
    required this.targetUnitId,
  });

  factory EventUnitCreated.fromJson(JsonEventUnitCreated json) =>
      EventUnitCreated(
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
        targetBase: json.targetBase != null
            ? Location.fromJson(json.targetBase!)
            : null,
        targetUnitId: json.targetUnitId,
      );
}

class EventUnitMovementStarted implements Event {
  final String id;
  final Position currentPosition;
  final Position targetPosition;

  const EventUnitMovementStarted({
    required this.id,
    required this.currentPosition,
    required this.targetPosition,
  });

  factory EventUnitMovementStarted.fromJson(
    JsonEventUnitMovementStarted json,
  ) => EventUnitMovementStarted(
    id: json.id,
    currentPosition: Position.fromJson(json.currentPosition),
    targetPosition: Position.fromJson(json.targetPosition),
  );
}

class EventUnitMovementEnded implements Event {
  final String id;
  final Position currentPosition;
  final Location? lockedLocation;

  const EventUnitMovementEnded({
    required this.id,
    required this.currentPosition,
    required this.lockedLocation,
  });

  factory EventUnitMovementEnded.fromJson(JsonEventUnitMovementEnded json) =>
      EventUnitMovementEnded(
        id: json.id,
        currentPosition: Position.fromJson(json.currentPosition),
        lockedLocation: (json.lockedLocation != null)
            ? Location.fromJson(json.lockedLocation!)
            : null,
      );
}

class EventUnitAttack implements Event {
  final String attackerId;
  final String? targetUnitId;
  final JsonLocation? targetBaseLocation;
  final num damage;
  final bool targetDestroyed;

  const EventUnitAttack({
    required this.attackerId,
    required this.targetUnitId,
    required this.targetBaseLocation,
    required this.damage,
    required this.targetDestroyed,
  });

  factory EventUnitAttack.fromJson(JsonEventUnitAttack json) => EventUnitAttack(
    attackerId: json.attackerId,
    targetUnitId: json.targetUnitId,
    targetBaseLocation: json.targetBaseLocation,
    damage: json.damage,
    targetDestroyed: json.targetDestroyed,
  );
}

class EventUnitDamaged implements Event {
  final String unitId;
  final num damage;
  final bool unitDestroyed;

  const EventUnitDamaged({
    required this.unitId,
    required this.damage,
    required this.unitDestroyed,
  });

  factory EventUnitDamaged.fromJson(JsonEventUnitDamaged json) =>
      EventUnitDamaged(
        unitId: json.unitId,
        damage: json.damage,
        unitDestroyed: json.unitDestroyed,
      );
}

class EventMatchFinished implements Event {
  final String? winner;
  final String? loser;

  const EventMatchFinished({
    required this.winner,
    required this.loser,
  });

  factory EventMatchFinished.fromJson(JsonEventMatchFinished json) =>
      EventMatchFinished(winner: json.winner, loser: json.loser);
}
