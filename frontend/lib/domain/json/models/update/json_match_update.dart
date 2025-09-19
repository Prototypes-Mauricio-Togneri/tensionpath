import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';

part 'json_match_update.g.dart';

@JsonSerializable()
class JsonMatchUpdate {
  @JsonKey(name: 'players')
  final Map<String, JsonPlayerUpdate> players;

  @JsonKey(name: 'missile')
  final JsonMissileUpdate missile;

  @JsonKey(name: 'resources')
  final Map<String, num> resources;

  @JsonKey(name: 'units')
  final Map<String, JsonUnitUpdate> units;

  JsonMatchUpdate({
    required this.players,
    required this.missile,
    required this.resources,
    required this.units,
  });

  factory JsonMatchUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchUpdateToJson(this);
}
