import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

part 'json_deploy_unit.g.dart';

@JsonSerializable()
class JsonDeployUnit {
  @JsonKey(name: 'matchId')
  final String matchId;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'type')
  final UnitType type;

  const JsonDeployUnit({
    required this.matchId,
    required this.location,
    required this.type,
  });

  factory JsonDeployUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonDeployUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonDeployUnitToJson(this);
}
