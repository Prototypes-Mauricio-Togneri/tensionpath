// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatch _$JsonMatchFromJson(Map<String, dynamic> json) => JsonMatch(
      id: json['id'] as String,
      remainingTime: (json['remainingTime'] as num).toDouble(),
      status: $enumDecode(_$MatchStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$JsonMatchToJson(JsonMatch instance) => <String, dynamic>{
      'id': instance.id,
      'remainingTime': instance.remainingTime,
      'status': _$MatchStatusEnumMap[instance.status]!,
    };

const _$MatchStatusEnumMap = {
  MatchStatus.playing: 'playing',
  MatchStatus.finished: 'finished',
};
