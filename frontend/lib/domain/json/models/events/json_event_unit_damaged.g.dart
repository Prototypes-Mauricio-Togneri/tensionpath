// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_unit_damaged.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventUnitDamaged _$JsonEventUnitDamagedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventUnitDamaged', json, ($checkedConvert) {
  final val = JsonEventUnitDamaged(
    unitId: $checkedConvert('unitId', (v) => v as String),
    damage: $checkedConvert('damage', (v) => v as num),
    unitDestroyed: $checkedConvert('unitDestroyed', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$JsonEventUnitDamagedToJson(
  JsonEventUnitDamaged instance,
) => <String, dynamic>{
  'unitId': instance.unitId,
  'damage': instance.damage,
  'unitDestroyed': instance.unitDestroyed,
};
