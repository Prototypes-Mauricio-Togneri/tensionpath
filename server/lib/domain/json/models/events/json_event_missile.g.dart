// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_missile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventMissile _$JsonEventMissileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonEventMissile', json, ($checkedConvert) {
      final val = JsonEventMissile(
        charge: $checkedConvert('charge', (v) => v as num),
        owner: $checkedConvert('owner', (v) => v as String?),
        platforms: $checkedConvert(
          'platforms',
          (v) => Map<String, String?>.from(v as Map),
        ),
        fired: $checkedConvert('fired', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$JsonEventMissileToJson(JsonEventMissile instance) =>
    <String, dynamic>{
      'charge': instance.charge,
      'owner': ?instance.owner,
      'platforms': instance.platforms,
      'fired': instance.fired,
    };
