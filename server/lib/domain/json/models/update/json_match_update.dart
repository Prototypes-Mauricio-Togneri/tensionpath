import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/match_status.dart';

part 'json_match_update.g.dart';

@JsonSerializable()
class JsonMatchUpdate {
  @JsonKey(name: 'status')
  final MatchStatus status;

  @JsonKey(name: 'players')
  final Map<String, JsonPlayerUpdate> players;

  @JsonKey(name: 'missile')
  final JsonMissileUpdate missile;

  @JsonKey(name: 'resources')
  final Map<String, num> resources;

  @JsonKey(name: 'units')
  final Map<String, JsonUnitUpdate> units;

  @JsonKey(name: 'events')
  final List<JsonEvent> events;

  JsonMatchUpdate({
    required this.status,
    required this.players,
    required this.missile,
    required this.resources,
    required this.units,
    required this.events,
  });

  factory JsonMatchUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchUpdateToJson(this);
}
