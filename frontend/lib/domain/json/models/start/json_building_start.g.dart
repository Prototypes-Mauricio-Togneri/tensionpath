// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_building_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBuildingStart _$JsonBuildingStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonBuildingStart', json, ($checkedConvert) {
      final val = JsonBuildingStart(
        playerIndex: $checkedConvert('playerIndex', (v) => v as String),
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

Map<String, dynamic> _$JsonBuildingStartToJson(JsonBuildingStart instance) =>
    <String, dynamic>{
      'playerIndex': instance.playerIndex,
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
    };
