// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonResource _$JsonResourceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonResource', json, ($checkedConvert) {
      final val = JsonResource(
        id: $checkedConvert('id', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        amountCurrent: $checkedConvert('amountCurrent', (v) => v as num),
        amountMax: $checkedConvert('amountMax', (v) => v as num),
        position: $checkedConvert(
          'position',
          (v) => v == null
              ? const JsonPosition(x: 0, y: 0)
              : JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonResourceToJson(JsonResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
      'amountCurrent': instance.amountCurrent,
      'amountMax': instance.amountMax,
    };
