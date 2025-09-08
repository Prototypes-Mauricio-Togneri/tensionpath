// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_create_battle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonCreateBattle _$JsonCreateBattleFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonCreateBattle', json, ($checkedConvert) {
      final val = JsonCreateBattle(
        battleId: $checkedConvert('battleId', (v) => v as String),
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
          (v) => Map<String, String>.from(v as Map),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonCreateBattleToJson(JsonCreateBattle instance) =>
    <String, dynamic>{
      'battleId': instance.battleId,
      'createdAt': instance.createdAt.toIso8601String(),
      'numberOfPlayers': instance.numberOfPlayers,
      'matchType': instance.matchType,
      'players': instance.players,
    };
