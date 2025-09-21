import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_move_unit.g.dart';

@JsonSerializable()
class JsonMoveUnit {
  @JsonKey(name: 'matchId')
  final String matchId;

  @JsonKey(name: 'unitId')
  final String unitId;

  @JsonKey(name: 'location')
  final JsonLocation location;

  const JsonMoveUnit({
    required this.matchId,
    required this.unitId,
    required this.location,
  });

  factory JsonMoveUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonMoveUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMoveUnitToJson(this);
}
