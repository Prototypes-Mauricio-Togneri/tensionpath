import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/types/building_type.dart';

part 'json_unlock_building.g.dart';

@JsonSerializable()
class JsonUnlockBuilding {
  @JsonKey(name: 'matchId')
  final String matchId;

  @JsonKey(name: 'type')
  final BuildingType type;

  const JsonUnlockBuilding({
    required this.matchId,
    required this.type,
  });

  factory JsonUnlockBuilding.fromJson(Map<String, dynamic> json) =>
      _$JsonUnlockBuildingFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnlockBuildingToJson(this);
}
