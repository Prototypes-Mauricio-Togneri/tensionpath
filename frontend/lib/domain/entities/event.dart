import 'package:tensionpath/domain/json/messages/server_client/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_resource_depleted.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';

class Event {
  static Event fromJson(JsonEvent json) {
    if (json.missile != null) {
      return EventMissile.fromJson(json.missile!);
    } else if (json.player != null) {
      return EventPlayer.fromJson(json.player!);
    } else if (json.resourceDepleted != null) {
      return EventResourcesDepleted.fromJson(json.resourceDepleted!);
    } else {
      throw UnimplementedError('Unknown event type');
    }
  }
}

/*
  @JsonKey(name: 'resource_depleted')
  final JsonEventResourceDepleted? resourceDepleted;

  @JsonKey(name: 'unit_created')
  final JsonEventUnitCreated? unitCreated;

  @JsonKey(name: 'unit_movement_started')
  final JsonEventUnitMovementStarted? unitMovementStarted;

  @JsonKey(name: 'unit_movement_ended')
  final JsonEventUnitMovementEnded? unitMovementEnded;

  @JsonKey(name: 'unit_updated')
  final JsonEventUnitUpdated? unitUpdated;

  @JsonKey(name: 'unit_destroyed')
  final JsonEventUnitDestroyed? unitDestroyed;

  @JsonKey(name: 'match_finished')
  final JsonEventMatchFinished? matchFinished;
*/

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
