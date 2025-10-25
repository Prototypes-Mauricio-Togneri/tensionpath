// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_base_damaged.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventBaseDamaged _$JsonEventBaseDamagedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventBaseDamaged', json, ($checkedConvert) {
  final val = JsonEventBaseDamaged(
    playerIndex: $checkedConvert('playerIndex', (v) => v as String),
    damage: $checkedConvert('damage', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$JsonEventBaseDamagedToJson(
  JsonEventBaseDamaged instance,
) => <String, dynamic>{
  'playerIndex': instance.playerIndex,
  'damage': instance.damage,
};
