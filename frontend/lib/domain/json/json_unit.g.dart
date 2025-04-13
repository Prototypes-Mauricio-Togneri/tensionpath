// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnit _$JsonUnitFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonUnit', json, ($checkedConvert) {
  final val = JsonUnit(
    type: $checkedConvert('type', (v) => $enumDecode(_$UnitTypeEnumMap, v)),
    deploymentCost: $checkedConvert(
      'deploymentCost',
      (v) => (v as num).toInt(),
    ),
    movementCost: $checkedConvert('movementCost', (v) => (v as num).toInt()),
    health: $checkedConvert('health', (v) => (v as num).toInt()),
    maxHealth: $checkedConvert('maxHealth', (v) => (v as num).toInt()),
    visibilityRange: $checkedConvert(
      'visibilityRange',
      (v) => (v as num).toInt(),
    ),
    movementRange: $checkedConvert('movementRange', (v) => (v as num).toInt()),
    attackRange: $checkedConvert('attackRange', (v) => (v as num).toInt()),
    moves: $checkedConvert('moves', (v) => (v as num).toInt()),
    player: $checkedConvert('player', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$JsonUnitToJson(JsonUnit instance) => <String, dynamic>{
  'type': _$UnitTypeEnumMap[instance.type]!,
  'deploymentCost': instance.deploymentCost,
  'movementCost': instance.movementCost,
  'health': instance.health,
  'maxHealth': instance.maxHealth,
  'visibilityRange': instance.visibilityRange,
  'movementRange': instance.movementRange,
  'attackRange': instance.attackRange,
  'moves': instance.moves,
  'player': instance.player,
};

const _$UnitTypeEnumMap = {
  UnitType.rifle_squad: 'rifle_squad',
  UnitType.sniper: 'sniper',
  UnitType.humvee: 'humvee',
  UnitType.tank: 'tank',
  UnitType.artillery: 'artillery',
  UnitType.helicopter: 'helicopter',
};
