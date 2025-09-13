// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissile _$JsonMissileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMissile', json, ($checkedConvert) {
      final val = JsonMissile(
        chargeMax: $checkedConvert('chargeMax', (v) => (v as num).toDouble()),
        chargeBuffer: $checkedConvert(
          'chargeBuffer',
          (v) => (v as num).toDouble(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMissileToJson(JsonMissile instance) =>
    <String, dynamic>{
      'chargeMax': instance.chargeMax,
      'chargeBuffer': instance.chargeBuffer,
    };
