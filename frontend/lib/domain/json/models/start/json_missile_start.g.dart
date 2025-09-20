// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissileStart _$JsonMissileStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMissileStart', json, ($checkedConvert) {
      final val = JsonMissileStart(
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        chargeMax: $checkedConvert('chargeMax', (v) => v as num),
        chargeBuffer: $checkedConvert('chargeBuffer', (v) => v as num),
        platforms: $checkedConvert(
          'platforms',
          (v) => (v as List<dynamic>)
              .map((e) => JsonPlatformStart.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMissileStartToJson(JsonMissileStart instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
      'chargeMax': instance.chargeMax,
      'chargeBuffer': instance.chargeBuffer,
      'platforms': instance.platforms.map((e) => e.toJson()).toList(),
    };
