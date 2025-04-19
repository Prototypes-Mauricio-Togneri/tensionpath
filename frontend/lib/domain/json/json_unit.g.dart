// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnit _$JsonUnitFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnit', json, ($checkedConvert) {
      final val = JsonUnit(
        type: $checkedConvert('type', (v) => $enumDecode(_$UnitTypeEnumMap, v)),
        health: $checkedConvert('health', (v) => (v as num).toInt()),
        remainingMoves: $checkedConvert(
          'remainingMoves',
          (v) => (v as num).toInt(),
        ),
        remainingAttacks: $checkedConvert(
          'remainingAttacks',
          (v) => (v as num).toInt(),
        ),
        player: $checkedConvert('player', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitToJson(JsonUnit instance) => <String, dynamic>{
  'type': _$UnitTypeEnumMap[instance.type]!,
  'health': instance.health,
  'remainingMoves': instance.remainingMoves,
  'remainingAttacks': instance.remainingAttacks,
  'player': instance.player,
};

const _$UnitTypeEnumMap = {
  UnitType.fuel_truck: 'fuel_truck',
  UnitType.rifle_squad: 'rifle_squad',
  UnitType.rpg_team: 'rpg_team',
  UnitType.sniper: 'sniper',
  UnitType.humvee: 'humvee',
  UnitType.rocket_vehicle: 'rocket_vehicle',
  UnitType.tank: 'tank',
  UnitType.artillery: 'artillery',
  UnitType.helicopter: 'helicopter',
};
