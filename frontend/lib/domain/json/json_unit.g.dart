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
        type: $checkedConvert('type', (v) => $enumDecode(_$UnitTypeEnumMap, v)),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitToJson(JsonUnit instance) => <String, dynamic>{
  'playerId': instance.playerId,
  'level': instance.level,
  'type': _$UnitTypeEnumMap[instance.type]!,
};

const _$UnitTypeEnumMap = {
  UnitType.fire: 'fire',
  UnitType.water: 'water',
  UnitType.plant: 'plant',
};
