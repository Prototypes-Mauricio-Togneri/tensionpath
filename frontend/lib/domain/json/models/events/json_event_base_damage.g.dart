// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_base_damage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventBaseDamage _$JsonEventBaseDamageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonEventBaseDamage', json, ($checkedConvert) {
      final val = JsonEventBaseDamage(
        playerIndex: $checkedConvert('playerIndex', (v) => v as String),
        damage: $checkedConvert('damage', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$JsonEventBaseDamageToJson(
  JsonEventBaseDamage instance,
) => <String, dynamic>{
  'playerIndex': instance.playerIndex,
  'damage': instance.damage,
};
