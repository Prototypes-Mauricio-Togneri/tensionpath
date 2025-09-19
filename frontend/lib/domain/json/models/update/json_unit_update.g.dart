// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnitUpdate _$JsonUnitUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnitUpdate', json, ($checkedConvert) {
      final val = JsonUnitUpdate(
        id: $checkedConvert('id', (v) => v as String),
        playerIndex: $checkedConvert('playerIndex', (v) => v as String),
        type: $checkedConvert('type', (v) => $enumDecode(_$UnitTypeEnumMap, v)),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        health: $checkedConvert('health', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitUpdateToJson(JsonUnitUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerIndex': instance.playerIndex,
      'type': _$UnitTypeEnumMap[instance.type]!,
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
      'health': instance.health,
    };

const _$UnitTypeEnumMap = {
  UnitType.harvester: 'harvester',
  UnitType.infrantry: 'infrantry',
  UnitType.vehicle: 'vehicle',
  UnitType.aircraft: 'aircraft',
};
