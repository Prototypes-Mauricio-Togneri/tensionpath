// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_platform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlatform _$JsonPlatformFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlatform', json, ($checkedConvert) {
      final val = JsonPlatform(
        id: $checkedConvert('id', (v) => v as String),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        owner: $checkedConvert('owner', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlatformToJson(JsonPlatform instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position.toJson(),
      'owner': ?instance.owner,
    };
