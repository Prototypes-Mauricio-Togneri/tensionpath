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
  UnitType.riflemen: 'riflemen',
  UnitType.shocks: 'shocks',
  UnitType.missiles: 'missiles',
  UnitType.grenadier: 'grenadier',
  UnitType.sniper: 'sniper',
  UnitType.rhino: 'rhino',
  UnitType.pitbull: 'pitbull',
  UnitType.shatterer: 'shatterer',
  UnitType.predator: 'predator',
  UnitType.mlrs: 'mlrs',
  UnitType.talon: 'talon',
  UnitType.razorback: 'razorback',
  UnitType.orca: 'orca',
  UnitType.mohawk: 'mohawk',
  UnitType.hammerhead: 'hammerhead',
  UnitType.wolverine: 'wolverine',
  UnitType.disruptor: 'disruptor',
  UnitType.zone: 'zone',
  UnitType.titan: 'titan',
  UnitType.mammoth: 'mammoth',
};
