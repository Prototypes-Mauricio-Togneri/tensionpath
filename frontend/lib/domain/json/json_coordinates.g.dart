// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonCoordinates _$JsonCoordinatesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonCoordinates', json, ($checkedConvert) {
      final val = JsonCoordinates(
        x: $checkedConvert('x', (v) => (v as num).toDouble()),
        y: $checkedConvert('y', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$JsonCoordinatesToJson(JsonCoordinates instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};
