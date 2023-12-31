import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_launch_units.g.dart';

@JsonSerializable(includeIfNull: false)
class JsonLaunchUnits {
  @JsonKey(name: 'roomId')
  final String roomId;

  @JsonKey(name: 'laneId')
  final int laneId;

  @JsonKey(name: 'amount')
  final int amount;

  const JsonLaunchUnits({
    required this.roomId,
    required this.laneId,
    required this.amount,
  });

  factory JsonLaunchUnits.fromString(String json) =>
      JsonLaunchUnits.fromJson(jsonDecode(json));

  factory JsonLaunchUnits.fromJson(Map<String, dynamic> json) =>
      _$JsonLaunchUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaunchUnitsToJson(this);
}
