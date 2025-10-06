// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_create_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonCreateMatch _$JsonCreateMatchFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonCreateMatch', json, ($checkedConvert) {
      final val = JsonCreateMatch(
        matchId: $checkedConvert('matchId', (v) => v as String),
        mapId: $checkedConvert('mapId', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        numberOfPlayers: $checkedConvert(
          'numberOfPlayers',
          (v) => (v as num).toInt(),
        ),
        matchType: $checkedConvert('matchType', (v) => v as String),
        players: $checkedConvert(
          'players',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) =>
                MapEntry(k, JsonPlayer.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonCreateMatchToJson(JsonCreateMatch instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'mapId': instance.mapId,
      'createdAt': instance.createdAt.toIso8601String(),
      'numberOfPlayers': instance.numberOfPlayers,
      'matchType': instance.matchType,
      'players': instance.players.map((k, e) => MapEntry(k, e.toJson())),
    };
