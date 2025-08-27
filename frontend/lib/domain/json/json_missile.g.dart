// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissile _$JsonMissileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMissile', json, ($checkedConvert) {
      final val = JsonMissile(
        charge: $checkedConvert('charge', (v) => (v as num).toDouble()),
        maxCharge: $checkedConvert('maxCharge', (v) => (v as num).toDouble()),
        bufferCharge: $checkedConvert(
          'bufferCharge',
          (v) => (v as num).toDouble(),
        ),
        platforms: $checkedConvert(
          'platforms',
          (v) => (v as List<dynamic>)
              .map((e) => JsonPlatform.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMissileToJson(JsonMissile instance) =>
    <String, dynamic>{
      'charge': instance.charge,
      'maxCharge': instance.maxCharge,
      'bufferCharge': instance.bufferCharge,
      'platforms': instance.platforms.map((e) => e.toJson()).toList(),
    };
