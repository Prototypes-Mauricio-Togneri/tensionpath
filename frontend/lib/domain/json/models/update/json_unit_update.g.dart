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
  );
  return val;
});

Map<String, dynamic> _$JsonUnitUpdateToJson(JsonUnitUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerIndex': instance.playerIndex,
      'type': _$UnitTypeEnumMap[instance.type]!,
      'health': instance.health,
      'currentPosition': instance.currentPosition.toJson(),
      'targetPosition': ?instance.targetPosition?.toJson(),
      'lockedLocation': ?instance.lockedLocation?.toJson(),
    };

const _$UnitTypeEnumMap = {
  UnitType.harvester: 'harvester',
  UnitType.infrantry: 'infrantry',
  UnitType.vehicle: 'vehicle',
  UnitType.aircraft: 'aircraft',
};
