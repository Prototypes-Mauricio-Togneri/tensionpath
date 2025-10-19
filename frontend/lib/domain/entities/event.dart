import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_match_finished.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_resource_depleted.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_created.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_destroyed.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_ended.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_unit_movement_started.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Event {
  static Event fromJson(JsonEvent json) {
    if (json.missile != null) {
      return EventMissile.fromJson(json.missile!);
    } else if (json.player != null) {
      return EventPlayer.fromJson(json.player!);
    } else if (json.resourceDepleted != null) {
      return EventResourcesDepleted.fromJson(json.resourceDepleted!);
    } else if (json.unitCreated != null) {
      return EventUnitCreated.fromJson(json.unitCreated!);
    } else if (json.unitMovementStarted != null) {
      return EventUnitMovementStarted.fromJson(json.unitMovementStarted!);
    } else if (json.unitMovementEnded != null) {
      return EventUnitMovementEnded.fromJson(json.unitMovementEnded!);
    } else if (json.unitDestroyed != null) {
      return EventUnitDestroyed.fromJson(json.unitDestroyed!);
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
  final bool alarm;
  final bool fired;

  const EventMissile({
    required this.charge,
    required this.owner,
    required this.platforms,
    required this.alarm,
    required this.fired,
  });

  factory EventMissile.fromJson(JsonEventMissile json) => EventMissile(
    charge: json.charge,
    owner: json.owner,
    platforms: Map<String, String?>.from(json.platforms),
    alarm: json.alarm,
    fired: json.fired,
  );
}

class EventPlayer implements Event {
  final String id;
  final num baseHealth;
  final num resources;
  final num resourcesRate;
  final int currentHarvesterCount;

  const EventPlayer({
    required this.id,
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
    required this.currentHarvesterCount,
  });

  factory EventPlayer.fromJson(JsonEventPlayer json) => EventPlayer(
    id: json.id,
    baseHealth: json.baseHealth,
    resources: json.resources,
    resourcesRate: json.resourcesRate,
    currentHarvesterCount: json.currentHarvesterCount,
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

  factory EventUnitMovementEnded.fromJson(
    JsonEventUnitMovementEnded json,
  ) => EventUnitMovementEnded(
    id: json.id,
    currentPosition: Position.fromJson(json.currentPosition),
    lockedLocation: (json.lockedLocation != null)
        ? Location.fromJson(json.lockedLocation!)
        : null,
  );
}

class EventUnitDestroyed implements Event {
  final String id;

  const EventUnitDestroyed({
    required this.id,
  });

  factory EventUnitDestroyed.fromJson(
    JsonEventUnitDestroyed json,
  ) => EventUnitDestroyed(id: json.id);
}

class EventMatchFinished implements Event {
  final String winner;

  const EventMatchFinished({
    required this.winner,
  });

  factory EventMatchFinished.fromJson(JsonEventMatchFinished json) =>
      EventMatchFinished(winner: json.winner);
}
