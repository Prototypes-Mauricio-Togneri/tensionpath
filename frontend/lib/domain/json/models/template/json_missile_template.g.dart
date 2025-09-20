// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_missile_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMissileTemplate _$JsonMissileTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMissileTemplate', json, ($checkedConvert) {
      final val = JsonMissileTemplate(
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        chargeMax: $checkedConvert('chargeMax', (v) => v as num),
        chargeBuffer: $checkedConvert('chargeBuffer', (v) => v as num),
        platforms: $checkedConvert(
          'platforms',
          (v) => (v as List<dynamic>)
              .map(
                (e) => JsonPlatformTemplate.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMissileTemplateToJson(
  JsonMissileTemplate instance,
) => <String, dynamic>{
  'location': instance.location.toJson(),
  'chargeMax': instance.chargeMax,
  'chargeBuffer': instance.chargeBuffer,
  'platforms': instance.platforms.map((e) => e.toJson()).toList(),
};
