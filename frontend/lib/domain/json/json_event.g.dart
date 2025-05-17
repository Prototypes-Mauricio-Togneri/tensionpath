// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEvent _$JsonEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEvent', json, ($checkedConvert) {
  final val = JsonEvent(
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$EventTypeEnumMap, v)),
    timestamp: $checkedConvert('timestamp', (v) => DateTime.parse(v as String)),
    nodeIdOrigin: $checkedConvert('nodeIdOrigin', (v) => v as String?),
    nodeIdTarget: $checkedConvert('nodeIdTarget', (v) => v as String?),
    unitType: $checkedConvert(
      'unitType',
      (v) => $enumDecodeNullable(_$UnitTypeEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonEventToJson(JsonEvent instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$EventTypeEnumMap[instance.type]!,
  if (dateToJson(instance.timestamp) case final value?) 'timestamp': value,
  if (instance.nodeIdOrigin case final value?) 'nodeIdOrigin': value,
  if (instance.nodeIdTarget case final value?) 'nodeIdTarget': value,
  if (_$UnitTypeEnumMap[instance.unitType] case final value?) 'unitType': value,
};

const _$EventTypeEnumMap = {
  EventType.deploy_unit: 'deploy_unit',
  EventType.move_unit: 'move_unit',
  EventType.attack_unit: 'attack_unit',
  EventType.attack_base: 'attack_base',
  EventType.end_turn_self: 'end_turn_self',
  EventType.end_turn_opponent: 'end_turn_opponent',
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
