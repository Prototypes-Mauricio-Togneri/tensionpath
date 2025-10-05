// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnitUpdate _$JsonUnitUpdateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonUnitUpdate', json, ($checkedConvert) {
  final val = JsonUnitUpdate(
    id: $checkedConvert('id', (v) => v as String),
    playerIndex: $checkedConvert('playerIndex', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$UnitTypeEnumMap, v)),
    maxHealth: $checkedConvert('maxHealth', (v) => v as num),
    health: $checkedConvert('health', (v) => v as num),
    currentPosition: $checkedConvert(
      'currentPosition',
      (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
    ),
    targetPosition: $checkedConvert(
      'targetPosition',
      (v) =>
          v == null ? null : JsonPosition.fromJson(v as Map<String, dynamic>),
    ),
    lockedLocation: $checkedConvert(
      'lockedLocation',
      (v) =>
          v == null ? null : JsonLocation.fromJson(v as Map<String, dynamic>),
    ),
    targetBase: $checkedConvert(
      'targetBase',
      (v) =>
          v == null ? null : JsonLocation.fromJson(v as Map<String, dynamic>),
    ),
    targetUnitId: $checkedConvert('targetUnitId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$JsonUnitUpdateToJson(JsonUnitUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerIndex': instance.playerIndex,
      'type': _$UnitTypeEnumMap[instance.type]!,
      'maxHealth': instance.maxHealth,
      'health': instance.health,
      'currentPosition': instance.currentPosition.toJson(),
      'targetPosition': ?instance.targetPosition?.toJson(),
      'lockedLocation': ?instance.lockedLocation?.toJson(),
      'targetBase': ?instance.targetBase?.toJson(),
      'targetUnitId': ?instance.targetUnitId,
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
};
