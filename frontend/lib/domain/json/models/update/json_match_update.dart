import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';

part 'json_match_update.g.dart';

@JsonSerializable()
class JsonMatchUpdate {
  @JsonKey(name: 'players')
  final Map<String, JsonPlayerUpdate> players;

  @JsonKey(name: 'missile')
  final JsonMissileUpdate missile;

  JsonMatchUpdate({
    required this.players,
    required this.missile,
  });

  factory JsonMatchUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchUpdateToJson(this);
}
