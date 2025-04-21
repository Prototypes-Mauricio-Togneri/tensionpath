// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissile _$JsonMissileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMissile', json, ($checkedConvert) {
      final val = JsonMissile(
        charge: $checkedConvert('charge', (v) => (v as num).toInt()),
        maxCharge: $checkedConvert('maxCharge', (v) => (v as num).toInt()),
        platforms: $checkedConvert('platforms', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonMissileToJson(JsonMissile instance) =>
    <String, dynamic>{
      'charge': instance.charge,
      'maxCharge': instance.maxCharge,
      'platforms': instance.platforms,
    };
