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
  UnitType.unit_10: 'harvester',
  UnitType.unit_20: 'infrantry',
  UnitType.unit_30: 'vehicle',
  UnitType.unit_40: 'aircraft',
};
