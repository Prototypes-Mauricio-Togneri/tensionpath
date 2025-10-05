import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_config.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield_start.dart';
import 'package:tensionpath/domain/json/models/start/json_player_start.dart';

part 'json_match_start.g.dart';

@JsonSerializable()
class JsonMatchStart {
  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'config')
  final JsonConfig config;

  @JsonKey(name: 'players')
  final List<JsonPlayerStart> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefieldStart battlefield;

  JsonMatchStart({
    required this.createdAt,
    required this.config,
    required this.players,
    required this.battlefield,
  });

  factory JsonMatchStart.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchStartToJson(this);
}
