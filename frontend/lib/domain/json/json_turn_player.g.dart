// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_turn_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonTurnPlayer _$JsonTurnPlayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonTurnPlayer', json, ($checkedConvert) {
      final val = JsonTurnPlayer(
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$PlayerStatusEnumMap, v),
        ),
        turnEndedAt: $checkedConvert(
          'turnEndedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonTurnPlayerToJson(
  JsonTurnPlayer instance,
) => <String, dynamic>{
  'status': _$PlayerStatusEnumMap[instance.status]!,
  if (dateToJson(instance.turnEndedAt) case final value?) 'turnEndedAt': value,
};

const _$PlayerStatusEnumMap = {
  PlayerStatus.playing: 'playing',
  PlayerStatus.waiting: 'waiting',
  PlayerStatus.ready: 'ready',
};
