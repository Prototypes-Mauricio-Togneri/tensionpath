import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/types/building_type.dart';

part 'json_building_start.g.dart';

@JsonSerializable()
class JsonBuildingStart {
  @JsonKey(name: 'type')
  final BuildingType type;

  @JsonKey(name: 'playerIndex')
  final String playerIndex;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'position')
  final JsonPosition position;

  const JsonBuildingStart({
    required this.type,
    required this.playerIndex,
    required this.location,
    required this.position,
  });

  factory JsonBuildingStart.fromJson(Map<String, dynamic> json) =>
      _$JsonBuildingStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBuildingStartToJson(this);
}
