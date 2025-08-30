// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissile _$JsonMissileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMissile', json, ($checkedConvert) {
      final val = JsonMissile(
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        chargeCurrent: $checkedConvert(
          'chargeCurrent',
          (v) => (v as num).toDouble(),
        ),
        chargeMax: $checkedConvert('chargeMax', (v) => (v as num).toDouble()),
        chargeBuffer: $checkedConvert(
          'chargeBuffer',
          (v) => (v as num).toDouble(),
        ),
        platforms: $checkedConvert(
          'platforms',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>)
                  .map((e) => JsonPosition.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMissileToJson(JsonMissile instance) =>
    <String, dynamic>{
      'position': instance.position.toJson(),
      'chargeCurrent': instance.chargeCurrent,
      'chargeMax': instance.chargeMax,
      'chargeBuffer': instance.chargeBuffer,
      'platforms': instance.platforms.map(
        (k, e) => MapEntry(k, e.map((e) => e.toJson()).toList()),
      ),
    };
