// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnitUpdate _$JsonUnitUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnitUpdate', json, ($checkedConvert) {
      final val = JsonUnitUpdate(
        id: $checkedConvert('id', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        health: $checkedConvert('health', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitUpdateToJson(JsonUnitUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
      'health': instance.health,
    };
