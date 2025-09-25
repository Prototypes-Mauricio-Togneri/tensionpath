// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_deploy_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonDeployUnit _$JsonDeployUnitFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonDeployUnit', json, ($checkedConvert) {
      final val = JsonDeployUnit(
        matchId: $checkedConvert('matchId', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        type: $checkedConvert('type', (v) => $enumDecode(_$UnitTypeEnumMap, v)),
      );
      return val;
    });

Map<String, dynamic> _$JsonDeployUnitToJson(JsonDeployUnit instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'location': instance.location.toJson(),
      'type': _$UnitTypeEnumMap[instance.type]!,
    };

const _$UnitTypeEnumMap = {
  UnitType.harvester: 'harvester',
  UnitType.plant_1: 'plant_1',
  UnitType.plant_2: 'plant_2',
  UnitType.plant_3: 'plant_3',
  UnitType.water_1: 'water_1',
  UnitType.water_2: 'water_2',
  UnitType.water_3: 'water_3',
  UnitType.flame_1: 'flame_1',
  UnitType.flame_2: 'flame_2',
  UnitType.flame_3: 'flame_3',
};
