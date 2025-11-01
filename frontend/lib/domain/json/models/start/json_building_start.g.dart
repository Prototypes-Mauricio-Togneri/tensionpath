// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_building_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBuildingStart _$JsonBuildingStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonBuildingStart', json, ($checkedConvert) {
      final val = JsonBuildingStart(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$BuildingTypeEnumMap, v),
        ),
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
      'type': _$BuildingTypeEnumMap[instance.type]!,
      'playerIndex': instance.playerIndex,
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
    };

const _$BuildingTypeEnumMap = {
  BuildingType.none: 'none',
  BuildingType.barracks: 'barracks',
  BuildingType.factory: 'factory',
  BuildingType.airfield: 'airfield',
};
