import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_lane_reward_won.g.dart';

@JsonSerializable()
class JsonLaneRewardWon {
  const JsonLaneRewardWon();

  factory JsonLaneRewardWon.fromString(String json) =>
      JsonLaneRewardWon.fromJson(jsonDecode(json));

  factory JsonLaneRewardWon.fromJson(Map<String, dynamic> json) =>
      _$JsonLaneRewardWonFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaneRewardWonToJson(this);
}
