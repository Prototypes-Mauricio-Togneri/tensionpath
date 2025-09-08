import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_launch_units.g.dart';

@JsonSerializable()
class JsonLaunchUnits {
  @JsonKey(name: 'battleId')
  final String battleId;

  @JsonKey(name: 'laneId')
  final int laneId;

  @JsonKey(name: 'amount')
  final int amount;

  const JsonLaunchUnits({
    required this.battleId,
    required this.laneId,
    required this.amount,
  });

  factory JsonLaunchUnits.fromString(String json) =>
      JsonLaunchUnits.fromJson(jsonDecode(json));

  factory JsonLaunchUnits.fromJson(Map<String, dynamic> json) =>
      _$JsonLaunchUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaunchUnitsToJson(this);
}
