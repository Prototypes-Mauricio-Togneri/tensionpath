// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_units_launched.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnitsLaunched _$JsonUnitsLaunchedFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnitsLaunched', json, ($checkedConvert) {
      final val = JsonUnitsLaunched(
        laneId: $checkedConvert('laneId', (v) => (v as num).toInt()),
        amount: $checkedConvert('amount', (v) => (v as num).toInt()),
        direction: $checkedConvert('direction', (v) => (v as num).toInt()),
        attackLevel: $checkedConvert('attackLevel', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitsLaunchedToJson(JsonUnitsLaunched instance) =>
    <String, dynamic>{
      'laneId': instance.laneId,
      'amount': instance.amount,
      'direction': instance.direction,
      'attackLevel': instance.attackLevel,
    };
