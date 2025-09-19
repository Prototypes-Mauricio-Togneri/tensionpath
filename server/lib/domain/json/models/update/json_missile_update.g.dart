// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissileUpdate _$JsonMissileUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMissileUpdate', json, ($checkedConvert) {
      final val = JsonMissileUpdate(
        charge: $checkedConvert('charge', (v) => v as num),
        owner: $checkedConvert('owner', (v) => v as String?),
        platforms: $checkedConvert(
          'platforms',
          (v) => Map<String, String?>.from(v as Map),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMissileUpdateToJson(JsonMissileUpdate instance) =>
    <String, dynamic>{
      'charge': instance.charge,
      'owner': ?instance.owner,
      'platforms': instance.platforms,
    };
