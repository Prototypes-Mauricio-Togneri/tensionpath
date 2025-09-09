import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_lane_won.g.dart';

@JsonSerializable()
class JsonLaneWon {
  const JsonLaneWon();

  factory JsonLaneWon.fromString(String json) =>
      JsonLaneWon.fromJson(jsonDecode(json));

  factory JsonLaneWon.fromJson(Map<String, dynamic> json) =>
      _$JsonLaneWonFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaneWonToJson(this);
}
