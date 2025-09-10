// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_join_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonJoinMatch _$JsonJoinMatchFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonJoinMatch', json, ($checkedConvert) {
      final val = JsonJoinMatch(
        matchId: $checkedConvert('matchId', (v) => v as String),
        playerId: $checkedConvert('playerId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonJoinMatchToJson(JsonJoinMatch instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'playerId': instance.playerId,
    };
