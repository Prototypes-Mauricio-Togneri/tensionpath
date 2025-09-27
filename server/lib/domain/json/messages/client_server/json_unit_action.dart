import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_unit_action.g.dart';

@JsonSerializable()
class JsonUnitAction {
  @JsonKey(name: 'matchId')
  final String matchId;

  @JsonKey(name: 'unitId')
  final String unitId;

  @JsonKey(name: 'targetLocation')
  final JsonLocation? targetLocation;

  @JsonKey(name: 'targetUnitId')
  final String? targetUnitId;

  const JsonUnitAction({
    required this.matchId,
    required this.unitId,
    required this.targetLocation,
    required this.targetUnitId,
  });

  factory JsonUnitAction.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitActionFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitActionToJson(this);
}
