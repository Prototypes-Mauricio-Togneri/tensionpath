import 'package:json_annotation/json_annotation.dart';

part 'json_surrender_match.g.dart';

@JsonSerializable()
class JsonSurrenderMatch {
  @JsonKey(name: 'matchId')
  final String matchId;

  const JsonSurrenderMatch({
    required this.matchId,
  });

  factory JsonSurrenderMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonSurrenderMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonSurrenderMatchToJson(this);
}
