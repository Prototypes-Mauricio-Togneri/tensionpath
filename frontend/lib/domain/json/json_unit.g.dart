// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnit _$JsonUnitFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnit', json, ($checkedConvert) {
      final val = JsonUnit(
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        coordinates: $checkedConvert(
          'coordinates',
          (v) => JsonCoordinates.fromJson(v as Map<String, dynamic>),
        ),
        health: $checkedConvert('health', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitToJson(JsonUnit instance) => <String, dynamic>{
  'location': instance.location.toJson(),
  'coordinates': instance.coordinates.toJson(),
  'health': instance.health,
};
