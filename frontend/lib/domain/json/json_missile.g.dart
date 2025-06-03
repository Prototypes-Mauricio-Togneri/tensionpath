// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissile _$JsonMissileFromJson(Map<String, dynamic> json) => $checkedCreate(
  'JsonMissile',
  json,
  ($checkedConvert) {
    final val = JsonMissile(
      charge: $checkedConvert('charge', (v) => (v as num).toInt()),
      maxCharge: $checkedConvert('maxCharge', (v) => (v as num).toInt()),
      bufferCharge: $checkedConvert('bufferCharge', (v) => (v as num).toInt()),
      numberOfPlatforms: $checkedConvert(
        'numberOfPlatforms',
        (v) => (v as num).toInt(),
      ),
      platforms: $checkedConvert(
        'platforms',
        (v) => Map<String, String?>.from(v as Map),
      ),
      owner: $checkedConvert('owner', (v) => v as String?),
    );
    return val;
  },
);

Map<String, dynamic> _$JsonMissileToJson(JsonMissile instance) =>
    <String, dynamic>{
      'charge': instance.charge,
      'maxCharge': instance.maxCharge,
      'bufferCharge': instance.bufferCharge,
      'numberOfPlatforms': instance.numberOfPlatforms,
      'platforms': instance.platforms,
      if (instance.owner case final value?) 'owner': value,
    };
