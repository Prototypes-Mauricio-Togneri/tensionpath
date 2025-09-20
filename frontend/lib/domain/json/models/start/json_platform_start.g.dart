// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_platform_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlatformStart _$JsonPlatformStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlatformStart', json, ($checkedConvert) {
      final val = JsonPlatformStart(
        id: $checkedConvert('id', (v) => v as String),
        pads: $checkedConvert(
          'pads',
          (v) => (v as List<dynamic>)
              .map((e) => JsonPadStart.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlatformStartToJson(JsonPlatformStart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pads': instance.pads.map((e) => e.toJson()).toList(),
    };
