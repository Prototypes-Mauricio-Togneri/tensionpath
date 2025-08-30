// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_platform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlatform _$JsonPlatformFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlatform', json, ($checkedConvert) {
      final val = JsonPlatform(
        id: $checkedConvert('id', (v) => v as String),
        owner: $checkedConvert('owner', (v) => v as String?),
        pads: $checkedConvert(
          'pads',
          (v) => (v as List<dynamic>)
              .map((e) => JsonPosition.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlatformToJson(JsonPlatform instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner': ?instance.owner,
      'pads': instance.pads.map((e) => e.toJson()).toList(),
    };
