import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield.dart';
import 'package:tensionpath/domain/json/models/start/json_player.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'players')
  final List<JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  JsonMatch({
    required this.createdAt,
    required this.players,
    required this.battlefield,
  });

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
