import 'package:tensionpath/domain/json/messages/server_client/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';

class Event {
  static Event fromJson(JsonEvent json) {
    if (json.player != null) {
      return EventPlayer.fromJson(json.player!);
    } else if (json.missile != null) {
      return EventMissile.fromJson(json.missile!);
    } else {
      throw UnimplementedError('Unknown event type');
    }
  }
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
