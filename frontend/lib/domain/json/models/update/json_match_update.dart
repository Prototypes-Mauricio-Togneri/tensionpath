import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';

part 'json_match_update.g.dart';

@JsonSerializable()
class JsonMatchUpdate {
  @JsonKey(name: 'players')
  final Map<String, JsonPlayerUpdate> players;

  JsonMatchUpdate({
    required this.players,
  });

  factory JsonMatchUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchUpdateToJson(this);
}
