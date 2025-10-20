import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_event_unit_attacked.g.dart';

@JsonSerializable()
class JsonEventUnitAttacked {
  @JsonKey(name: 'attackerId')
  final String attackerId;

  @JsonKey(name: 'targetUnitId')
  final String? targetUnitId;

  @JsonKey(name: 'targetBaseLocation')
  final JsonLocation? targetBaseLocation;

  @JsonKey(name: 'damage')
  final num damage;

  const JsonEventUnitAttacked({
    required this.attackerId,
    required this.targetUnitId,
    required this.targetBaseLocation,
    required this.damage,
  });

  factory JsonEventUnitAttacked.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitAttackedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitAttackedToJson(this);
}
