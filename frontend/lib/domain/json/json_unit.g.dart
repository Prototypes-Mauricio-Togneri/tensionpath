// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnit _$JsonUnitFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnit', json, ($checkedConvert) {
      final val = JsonUnit(
        playerId: $checkedConvert('playerId', (v) => v as String),
        level: $checkedConvert('level', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitToJson(JsonUnit instance) => <String, dynamic>{
  'playerId': instance.playerId,
  'level': instance.level,
};
