import 'package:json_annotation/json_annotation.dart';

part 'json_join_match.g.dart';

@JsonSerializable()
class JsonJoinMatch {
  @JsonKey(name: 'matchId')
  final String matchId;

  @JsonKey(name: 'playerId')
  final String playerId;

  const JsonJoinMatch({
    required this.matchId,
    required this.playerId,
  });

  factory JsonJoinMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonJoinMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonJoinMatchToJson(this);
}
