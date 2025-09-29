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
        players: $checkedConvert(
          'players',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              k,
              JsonPlayerUpdate.fromJson(e as Map<String, dynamic>),
            ),
          ),
        ),
        missile: $checkedConvert(
          'missile',
          (v) => JsonMissileUpdate.fromJson(v as Map<String, dynamic>),
        ),
        resources: $checkedConvert(
          'resources',
          (v) => Map<String, num>.from(v as Map),
        ),
        units: $checkedConvert(
          'units',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) =>
                MapEntry(k, JsonUnitUpdate.fromJson(e as Map<String, dynamic>)),
          ),
        ),
        winner: $checkedConvert('winner', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchUpdateToJson(JsonMatchUpdate instance) =>
    <String, dynamic>{
      'status': _$MatchStatusEnumMap[instance.status]!,
      'players': instance.players.map((k, e) => MapEntry(k, e.toJson())),
      'missile': instance.missile.toJson(),
      'resources': instance.resources,
      'units': instance.units.map((k, e) => MapEntry(k, e.toJson())),
      'winner': ?instance.winner,
    };

const _$MatchStatusEnumMap = {
  MatchStatus.playing: 'playing',
  MatchStatus.finished: 'finished',
};
