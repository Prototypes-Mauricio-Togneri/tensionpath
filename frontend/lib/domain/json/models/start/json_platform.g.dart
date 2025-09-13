// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_platform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlatform _$JsonPlatformFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlatform', json, ($checkedConvert) {
      final val = JsonPlatform(
        id: $checkedConvert('id', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlatformToJson(JsonPlatform instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location.toJson(),
    };
