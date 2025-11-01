// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_unit_created.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventUnitCreated _$JsonEventUnitCreatedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventUnitCreated', json, ($checkedConvert) {
  final val = JsonEventUnitCreated(
    id: $checkedConvert('id', (v) => v as String),
    playerIndex: $checkedConvert('playerIndex', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$UnitTypeEnumMap, v)),
    health: $checkedConvert('health', (v) => v as num),
    currentPosition: $checkedConvert(
      'currentPosition',
      (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
    ),
    targetPositions: $checkedConvert(
      'targetPositions',
      (v) => (v as List<dynamic>)
          .map((e) => JsonPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$JsonEventUnitCreatedToJson(
  JsonEventUnitCreated instance,
) => <String, dynamic>{
  'id': instance.id,
  'playerIndex': instance.playerIndex,
  'type': _$UnitTypeEnumMap[instance.type]!,
  'health': instance.health,
  'currentPosition': instance.currentPosition.toJson(),
  'targetPositions': instance.targetPositions.map((e) => e.toJson()).toList(),
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
