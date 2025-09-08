// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_join_battle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonJoinBattle _$JsonJoinBattleFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonJoinBattle', json, ($checkedConvert) {
      final val = JsonJoinBattle(
        battleId: $checkedConvert('battleId', (v) => v as String),
        playerId: $checkedConvert('playerId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonJoinBattleToJson(JsonJoinBattle instance) =>
    <String, dynamic>{
      'battleId': instance.battleId,
      'playerId': instance.playerId,
    };
