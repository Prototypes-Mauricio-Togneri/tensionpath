import 'package:tensionpath/domain/entities/event.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/types/match_status.dart';

class MatchUpdate {
  final MatchStatus status;
  final List<Event> events;

  const MatchUpdate({
    required this.status,
    required this.events,
  });

  List<T> eventsOfType<T extends Event>() => events.whereType<T>().toList();

  factory MatchUpdate.fromJson(JsonMatchUpdate json) => MatchUpdate(
    status: json.status,
    events: json.events.map(Event.fromJson).toList(),
  );
}
