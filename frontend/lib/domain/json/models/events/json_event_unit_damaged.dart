import 'package:json_annotation/json_annotation.dart';

part 'json_event_unit_damaged.g.dart';

@JsonSerializable()
class JsonEventUnitDamaged {
  @JsonKey(name: 'unitId')
  final String unitId;

  @JsonKey(name: 'damage')
  final num damage;

  @JsonKey(name: 'unitDestroyed')
  final bool unitDestroyed;

  const JsonEventUnitDamaged({
    required this.unitId,
    required this.damage,
    required this.unitDestroyed,
  });

  factory JsonEventUnitDamaged.fromJson(Map<String, dynamic> json) =>
      _$JsonEventUnitDamagedFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventUnitDamagedToJson(this);
}
