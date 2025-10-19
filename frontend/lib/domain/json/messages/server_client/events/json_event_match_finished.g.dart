// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_match_finished.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventMatchFinished _$JsonEventMatchFinishedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventMatchFinished', json, ($checkedConvert) {
  final val = JsonEventMatchFinished(
    winner: $checkedConvert('winner', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$JsonEventMatchFinishedToJson(
  JsonEventMatchFinished instance,
) => <String, dynamic>{'winner': instance.winner};
