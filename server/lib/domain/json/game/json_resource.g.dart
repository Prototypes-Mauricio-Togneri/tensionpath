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
        amountCurrent: $checkedConvert(
          'amountCurrent',
          (v) => (v as num).toDouble(),
        ),
        amountMax: $checkedConvert('amountMax', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$JsonResourceToJson(JsonResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location.toJson(),
      'amountCurrent': instance.amountCurrent,
      'amountMax': instance.amountMax,
    };
