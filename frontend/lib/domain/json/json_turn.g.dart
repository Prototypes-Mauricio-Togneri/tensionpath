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
          (v) => DateTime.parse(v as String),
        ),
        player2EndedTurnAt: $checkedConvert(
          'player2EndedTurnAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonTurnToJson(JsonTurn instance) => <String, dynamic>{
  'turn': instance.turn,
  'startedAt': dateToJson(instance.startedAt),
  'player1EndedTurnAt': dateToJson(instance.player1EndedTurnAt),
  'player2EndedTurnAt': dateToJson(instance.player2EndedTurnAt),
};
