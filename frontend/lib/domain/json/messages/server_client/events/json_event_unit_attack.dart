import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_event_unit_attack.g.dart';

@JsonSerializable()
class JsonEventUnitAttack {
  @JsonKey(name: 'attackerId')
  final String attackerId;

  @JsonKey(name: 'targetUnitId')
  final String? targetUnitId;

  @JsonKey(name: 'targetBaseLocation')
  final JsonLocation? targetBaseLocation;

  @JsonKey(name: 'damage')
  final num damage;

  @JsonKey(name: 'targetDestroyed')
  final bool targetDestroyed;

  const JsonEventUnitAttack({
    required this.attackerId,
    required this.targetUnitId,
    required this.targetBaseLocation,
    required this.damage,
    required this.targetDestroyed,
  });

  factory JsonEventUnitAttack.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitAttackFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitAttackToJson(this);
}
