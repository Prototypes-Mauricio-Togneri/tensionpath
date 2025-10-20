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
    defenderId: $checkedConvert('defenderId', (v) => v as String),
    damage: $checkedConvert('damage', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$JsonEventUnitAttackedToJson(
  JsonEventUnitAttacked instance,
) => <String, dynamic>{
  'attackerId': instance.attackerId,
  'defenderId': instance.defenderId,
  'damage': instance.damage,
};
