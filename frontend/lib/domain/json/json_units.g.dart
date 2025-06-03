// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_units.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnits _$JsonUnitsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnits', json, ($checkedConvert) {
      final val = JsonUnits(
        playerId: $checkedConvert('playerId', (v) => v as String),
        amount: $checkedConvert('amount', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitsToJson(JsonUnits instance) => <String, dynamic>{
  'playerId': instance.playerId,
  'amount': instance.amount,
};
