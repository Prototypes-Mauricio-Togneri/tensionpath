// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_launch_units.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLaunchUnits _$JsonLaunchUnitsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonLaunchUnits', json, ($checkedConvert) {
      final val = JsonLaunchUnits(
        matchId: $checkedConvert('matchId', (v) => v as String),
        laneId: $checkedConvert('laneId', (v) => (v as num).toInt()),
        amount: $checkedConvert('amount', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonLaunchUnitsToJson(JsonLaunchUnits instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'laneId': instance.laneId,
      'amount': instance.amount,
    };
