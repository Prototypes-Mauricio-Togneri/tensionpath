// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissile _$JsonMissileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMissile', json, ($checkedConvert) {
      final val = JsonMissile(
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        chargeMax: $checkedConvert('chargeMax', (v) => v as num),
        chargeBuffer: $checkedConvert('chargeBuffer', (v) => v as num),
        platforms: $checkedConvert(
          'platforms',
          (v) => (v as List<dynamic>)
              .map((e) => JsonPlatform.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        position: $checkedConvert(
          'position',
          (v) => v == null
              ? const JsonPosition(x: 0, y: 0)
              : JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMissileToJson(JsonMissile instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
      'chargeMax': instance.chargeMax,
      'chargeBuffer': instance.chargeBuffer,
      'platforms': instance.platforms.map((e) => e.toJson()).toList(),
    };
