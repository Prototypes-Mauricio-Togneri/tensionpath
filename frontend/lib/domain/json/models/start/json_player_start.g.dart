// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_player_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlayerStart _$JsonPlayerStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlayerStart', json, ($checkedConvert) {
      final val = JsonPlayerStart(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        isSelf: $checkedConvert('isSelf', (v) => v as bool),
        index: $checkedConvert('index', (v) => v as String),
        baseHealth: $checkedConvert('baseHealth', (v) => v as num),
        baseMaxHealth: $checkedConvert('baseMaxHealth', (v) => v as num),
        resources: $checkedConvert('resources', (v) => v as num),
        resourcesPassiveRate: $checkedConvert(
          'resourcesPassiveRate',
          (v) => v as num,
        ),
        resourcesActiveRate: $checkedConvert(
          'resourcesActiveRate',
          (v) => v as num,
        ),
        deck: $checkedConvert(
          'deck',
          (v) => (v as List<dynamic>)
              .map((e) => $enumDecode(_$UnitTypeEnumMap, e))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlayerStartToJson(JsonPlayerStart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelf': instance.isSelf,
      'index': instance.index,
      'baseHealth': instance.baseHealth,
      'baseMaxHealth': instance.baseMaxHealth,
      'resources': instance.resources,
      'resourcesPassiveRate': instance.resourcesPassiveRate,
      'resourcesActiveRate': instance.resourcesActiveRate,
      'deck': instance.deck.map((e) => _$UnitTypeEnumMap[e]!).toList(),
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
