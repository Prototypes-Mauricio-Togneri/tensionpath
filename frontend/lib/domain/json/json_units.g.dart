// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_units.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnits _$JsonUnitsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnits', json, ($checkedConvert) {
      final val = JsonUnits(
        player: $checkedConvert('player', (v) => v as String),
        amount: $checkedConvert('amount', (v) => (v as num).toInt()),
        moveToX: $checkedConvert('moveToX', (v) => (v as num?)?.toInt()),
        moveToY: $checkedConvert('moveToY', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitsToJson(JsonUnits instance) => <String, dynamic>{
  'player': instance.player,
  'amount': instance.amount,
  if (instance.moveToX case final value?) 'moveToX': value,
  if (instance.moveToY case final value?) 'moveToY': value,
};
