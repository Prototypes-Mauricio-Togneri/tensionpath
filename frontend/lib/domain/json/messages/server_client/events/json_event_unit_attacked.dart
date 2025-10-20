import 'package:json_annotation/json_annotation.dart';

part 'json_event_unit_attacked.g.dart';

@JsonSerializable()
class JsonEventUnitAttacked {
  @JsonKey(name: 'attackerId')
  final String attackerId;

  @JsonKey(name: 'defenderId')
  final String defenderId;

  @JsonKey(name: 'damage')
  final num damage;

  const JsonEventUnitAttacked({
    required this.attackerId,
    required this.defenderId,
    required this.damage,
  });

  factory JsonEventUnitAttacked.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitAttackedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitAttackedToJson(this);
}
