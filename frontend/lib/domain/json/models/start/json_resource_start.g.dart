// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_resource_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonResourceStart _$JsonResourceStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonResourceStart', json, ($checkedConvert) {
      final val = JsonResourceStart(
        id: $checkedConvert('id', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        amountCurrent: $checkedConvert('amountCurrent', (v) => v as num),
        amountMax: $checkedConvert('amountMax', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$JsonResourceStartToJson(JsonResourceStart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
      'amountCurrent': instance.amountCurrent,
      'amountMax': instance.amountMax,
    };
