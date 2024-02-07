import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_units_launched.g.dart';

@JsonSerializable(includeIfNull: false)
class JsonUnitsLaunched {
  @JsonKey(name: 'laneId')
  final int laneId;

  @JsonKey(name: 'amount')
  final int amount;

  @JsonKey(name: 'direction')
  final int direction;

  @JsonKey(name: 'attackLevel')
  final int attackLevel;

  const JsonUnitsLaunched({
    required this.laneId,
    required this.amount,
    required this.direction,
    required this.attackLevel,
  });

  factory JsonUnitsLaunched.fromString(String json) =>
      JsonUnitsLaunched.fromJson(jsonDecode(json));

  factory JsonUnitsLaunched.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitsLaunchedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitsLaunchedToJson(this);
}
