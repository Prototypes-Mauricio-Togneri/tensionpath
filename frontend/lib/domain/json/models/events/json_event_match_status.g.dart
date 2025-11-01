// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_match_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventMatchStatus _$JsonEventMatchStatusFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventMatchStatus', json, ($checkedConvert) {
  final val = JsonEventMatchStatus(
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$MatchStatusEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonEventMatchStatusToJson(
  JsonEventMatchStatus instance,
) => <String, dynamic>{'status': _$MatchStatusEnumMap[instance.status]!};

const _$MatchStatusEnumMap = {
  MatchStatus.playing: 'playing',
  MatchStatus.over: 'over',
  MatchStatus.finished: 'finished',
};
