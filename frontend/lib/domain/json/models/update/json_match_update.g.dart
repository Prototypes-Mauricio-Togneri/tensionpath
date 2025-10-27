// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatchUpdate _$JsonMatchUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMatchUpdate', json, ($checkedConvert) {
      final val = JsonMatchUpdate(
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$MatchStatusEnumMap, v),
        ),
        events: $checkedConvert(
          'events',
          (v) => (v as List<dynamic>)
              .map((e) => JsonEvent.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchUpdateToJson(JsonMatchUpdate instance) =>
    <String, dynamic>{
      'status': _$MatchStatusEnumMap[instance.status]!,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };

const _$MatchStatusEnumMap = {
  MatchStatus.playing: 'playing',
  MatchStatus.over: 'over',
  MatchStatus.finished: 'finished',
};
