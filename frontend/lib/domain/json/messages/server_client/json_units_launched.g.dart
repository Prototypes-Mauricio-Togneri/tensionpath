// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_units_launched.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnitsLaunched _$JsonUnitsLaunchedFromJson(Map<String, dynamic> json) =>
    JsonUnitsLaunched(
      laneId: json['laneId'] as int,
      amount: json['amount'] as int,
      direction: json['direction'] as int,
      attackLevel: json['attackLevel'] as int,
    );

Map<String, dynamic> _$JsonUnitsLaunchedToJson(JsonUnitsLaunched instance) =>
    <String, dynamic>{
      'laneId': instance.laneId,
      'amount': instance.amount,
      'direction': instance.direction,
      'attackLevel': instance.attackLevel,
    };
