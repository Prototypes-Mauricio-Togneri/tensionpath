// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_battlefield.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBattlefield _$JsonBattlefieldFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonBattlefield', json, ($checkedConvert) {
      final val = JsonBattlefield(
        size: $checkedConvert(
          'size',
          (v) => JsonSize.fromJson(v as Map<String, dynamic>),
        ),
        missile: $checkedConvert(
          'missile',
          (v) => JsonMissile.fromJson(v as Map<String, dynamic>),
        ),
        platforms: $checkedConvert(
          'platforms',
          (v) => (v as List<dynamic>)
              .map((e) => JsonPlatform.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        resources: $checkedConvert(
          'resources',
          (v) => (v as List<dynamic>)
              .map((e) => JsonResource.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonBattlefieldToJson(JsonBattlefield instance) =>
    <String, dynamic>{
      'size': instance.size.toJson(),
      'missile': instance.missile.toJson(),
      'platforms': instance.platforms.map((e) => e.toJson()).toList(),
      'resources': instance.resources.map((e) => e.toJson()).toList(),
    };
