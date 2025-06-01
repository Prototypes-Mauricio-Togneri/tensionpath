// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlayer _$JsonPlayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlayer', json, ($checkedConvert) {
      final val = JsonPlayer(
        name: $checkedConvert('name', (v) => v as String),
        baseHealth: $checkedConvert('baseHealth', (v) => (v as num).toInt()),
        resources: $checkedConvert('resources', (v) => (v as num).toInt()),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$PlayerStatusEnumMap, v),
        ),
        turnEndedAt: $checkedConvert(
          'turnEndedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        actions: $checkedConvert(
          'actions',
          (v) => JsonAction.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlayerToJson(
  JsonPlayer instance,
) => <String, dynamic>{
  'name': instance.name,
  'baseHealth': instance.baseHealth,
  'resources': instance.resources,
  'status': _$PlayerStatusEnumMap[instance.status]!,
  if (dateToJson(instance.turnEndedAt) case final value?) 'turnEndedAt': value,
  'actions': instance.actions.toJson(),
};

const _$PlayerStatusEnumMap = {
  PlayerStatus.playing: 'playing',
  PlayerStatus.waiting: 'waiting',
  PlayerStatus.ready: 'ready',
};
