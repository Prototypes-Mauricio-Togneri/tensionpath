// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_turn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonTurn _$JsonTurnFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonTurn', json, ($checkedConvert) {
      final val = JsonTurn(
        turn: $checkedConvert('turn', (v) => (v as num).toInt()),
        startedAt: $checkedConvert(
          'startedAt',
          (v) => DateTime.parse(v as String),
        ),
        player1: $checkedConvert(
          'player1',
          (v) => JsonTurnPlayer.fromJson(v as Map<String, dynamic>),
        ),
        player2: $checkedConvert(
          'player2',
          (v) => JsonTurnPlayer.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonTurnToJson(JsonTurn instance) => <String, dynamic>{
  'turn': instance.turn,
  if (dateToJson(instance.startedAt) case final value?) 'startedAt': value,
  'player1': instance.player1.toJson(),
  'player2': instance.player2.toJson(),
};
