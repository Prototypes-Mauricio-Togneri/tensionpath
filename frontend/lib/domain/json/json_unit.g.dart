// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnit _$JsonUnitFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnit', json, ($checkedConvert) {
      final val = JsonUnit(
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
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
  'position': instance.position.toJson(),
  'coordinates': instance.coordinates.toJson(),
  'health': instance.health,
};
