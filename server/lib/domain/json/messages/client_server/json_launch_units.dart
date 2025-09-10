import 'package:json_annotation/json_annotation.dart';

part 'json_launch_units.g.dart';

@JsonSerializable()
class JsonLaunchUnits {
  @JsonKey(name: 'matchId')
  final String matchId;

  @JsonKey(name: 'laneId')
  final int laneId;

  @JsonKey(name: 'amount')
  final int amount;

  const JsonLaunchUnits({
    required this.matchId,
    required this.laneId,
    required this.amount,
  });

  factory JsonLaunchUnits.fromJson(Map<String, dynamic> json) =>
      _$JsonLaunchUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaunchUnitsToJson(this);
}
