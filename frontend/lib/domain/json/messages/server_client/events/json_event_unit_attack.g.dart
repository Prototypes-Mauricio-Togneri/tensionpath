// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_unit_attack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventUnitAttack _$JsonEventUnitAttackFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonEventUnitAttack', json, ($checkedConvert) {
      final val = JsonEventUnitAttack(
        attackerId: $checkedConvert('attackerId', (v) => v as String),
        targetUnitId: $checkedConvert('targetUnitId', (v) => v as String?),
        targetBaseLocation: $checkedConvert(
          'targetBaseLocation',
          (v) => v == null
              ? null
              : JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        damage: $checkedConvert('damage', (v) => v as num),
        targetDestroyed: $checkedConvert('targetDestroyed', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$JsonEventUnitAttackToJson(
  JsonEventUnitAttack instance,
) => <String, dynamic>{
  'attackerId': instance.attackerId,
  'targetUnitId': ?instance.targetUnitId,
  'targetBaseLocation': ?instance.targetBaseLocation?.toJson(),
  'damage': instance.damage,
  'targetDestroyed': instance.targetDestroyed,
};
