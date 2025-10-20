// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_unit_attacked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventUnitAttacked _$JsonEventUnitAttackedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventUnitAttacked', json, ($checkedConvert) {
  final val = JsonEventUnitAttacked(
    attackerId: $checkedConvert('attackerId', (v) => v as String),
    targetUnitId: $checkedConvert('targetUnitId', (v) => v as String?),
    targetBase: $checkedConvert(
      'targetBase',
      (v) =>
          v == null ? null : JsonLocation.fromJson(v as Map<String, dynamic>),
    ),
    damage: $checkedConvert('damage', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$JsonEventUnitAttackedToJson(
  JsonEventUnitAttacked instance,
) => <String, dynamic>{
  'attackerId': instance.attackerId,
  'targetUnitId': ?instance.targetUnitId,
  'targetBase': ?instance.targetBase?.toJson(),
  'damage': instance.damage,
};
