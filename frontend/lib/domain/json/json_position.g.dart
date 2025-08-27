// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPosition _$JsonPositionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPosition', json, ($checkedConvert) {
      final val = JsonPosition(
        x: $checkedConvert('x', (v) => (v as num).toInt()),
        y: $checkedConvert('y', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonPositionToJson(JsonPosition instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};
