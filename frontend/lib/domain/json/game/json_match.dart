import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/types/match_status.dart';

part 'json_match.g.dart';

@JsonSerializable(includeIfNull: false)
class JsonMatch {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'remainingTime')
  final double remainingTime;

  @JsonKey(name: 'status')
  final MatchStatus status;

  const JsonMatch({
    required this.id,
    required this.remainingTime,
    required this.status,
  });

  factory JsonMatch.fromString(String json) =>
      JsonMatch.fromJson(jsonDecode(json));

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
