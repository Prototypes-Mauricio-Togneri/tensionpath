// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUser _$JsonUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUser', json, ($checkedConvert) {
      final val = JsonUser(
        name: $checkedConvert('name', (v) => v as String),
        deck: $checkedConvert(
          'deck',
          (v) => (v as List<dynamic>)
              .map((e) => $enumDecode(_$UnitTypeEnumMap, e))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonUserToJson(JsonUser instance) => <String, dynamic>{
  'name': instance.name,
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
