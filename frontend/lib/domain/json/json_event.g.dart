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
  );
  return val;
});

Map<String, dynamic> _$JsonEventToJson(JsonEvent instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$EventTypeEnumMap[instance.type]!,
  if (dateToJson(instance.timestamp) case final value?) 'timestamp': value,
  if (instance.nodeIdOrigin case final value?) 'nodeIdOrigin': value,
  if (instance.nodeIdTarget case final value?) 'nodeIdTarget': value,
};

const _$EventTypeEnumMap = {
  EventType.deploy_unit: 'deploy_unit',
  EventType.move_unit: 'move_unit',
  EventType.attack_unit: 'attack_unit',
  EventType.attack_base: 'attack_base',
  EventType.end_turn_self: 'end_turn_self',
  EventType.end_turn_opponent: 'end_turn_opponent',
};
