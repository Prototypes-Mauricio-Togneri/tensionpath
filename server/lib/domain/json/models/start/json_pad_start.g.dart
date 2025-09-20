// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_pad_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPadStart _$JsonPadStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPadStart', json, ($checkedConvert) {
      final val = JsonPadStart(
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPadStartToJson(JsonPadStart instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
    };
