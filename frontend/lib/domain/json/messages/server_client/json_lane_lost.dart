import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_lane_lost.g.dart';

@JsonSerializable()
class JsonLaneLost {
  const JsonLaneLost();

  factory JsonLaneLost.fromString(String json) =>
      JsonLaneLost.fromJson(jsonDecode(json));

  factory JsonLaneLost.fromJson(Map<String, dynamic> json) =>
      _$JsonLaneLostFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaneLostToJson(this);
}
