// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonAction _$JsonActionFromJson(Map<String, dynamic> json) => $checkedCreate(
  'JsonAction',
  json,
  ($checkedConvert) {
    final val = JsonAction(
      type: $checkedConvert('type', (v) => $enumDecode(_$ActionTypeEnumMap, v)),
      playerId: $checkedConvert('playerId', (v) => v as String),
      originX: $checkedConvert('originX', (v) => (v as num?)?.toInt()),
      originY: $checkedConvert('originY', (v) => (v as num?)?.toInt()),
      targetX: $checkedConvert('targetX', (v) => (v as num).toInt()),
      targetY: $checkedConvert('targetY', (v) => (v as num).toInt()),
      amount: $checkedConvert('amount', (v) => (v as num?)?.toInt()),
    );
    return val;
  },
);

Map<String, dynamic> _$JsonActionToJson(JsonAction instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
      'playerId': instance.playerId,
      if (instance.originX case final value?) 'originX': value,
      if (instance.originY case final value?) 'originY': value,
      'targetX': instance.targetX,
      'targetY': instance.targetY,
      if (instance.amount case final value?) 'amount': value,
    };

const _$ActionTypeEnumMap = {
  ActionType.deploy: 'deploy',
  ActionType.move: 'move',
};
