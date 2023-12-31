// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_launch_units.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLaunchUnits _$JsonLaunchUnitsFromJson(Map<String, dynamic> json) =>
    JsonLaunchUnits(
      roomId: json['roomId'] as String,
      laneId: json['laneId'] as int,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$JsonLaunchUnitsToJson(JsonLaunchUnits instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'laneId': instance.laneId,
      'amount': instance.amount,
    };
