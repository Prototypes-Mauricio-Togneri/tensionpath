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
        player1EndedTurnAt: $checkedConvert(
          'player1EndedTurnAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        player2EndedTurnAt: $checkedConvert(
          'player2EndedTurnAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonTurnToJson(JsonTurn instance) => <String, dynamic>{
  'turn': instance.turn,
  if (dateToJson(instance.startedAt) case final value?) 'startedAt': value,
  if (dateToJson(instance.player1EndedTurnAt) case final value?)
    'player1EndedTurnAt': value,
  if (dateToJson(instance.player2EndedTurnAt) case final value?)
    'player2EndedTurnAt': value,
};
