import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_lane_reward_lost.g.dart';

@JsonSerializable()
class JsonLaneRewardLost {
  const JsonLaneRewardLost();

  factory JsonLaneRewardLost.fromString(String json) =>
      JsonLaneRewardLost.fromJson(jsonDecode(json));

  factory JsonLaneRewardLost.fromJson(Map<String, dynamic> json) =>
      _$JsonLaneRewardLostFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaneRewardLostToJson(this);
}
