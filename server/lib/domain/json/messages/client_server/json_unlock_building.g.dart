// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unlock_building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnlockBuilding _$JsonUnlockBuildingFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnlockBuilding', json, ($checkedConvert) {
      final val = JsonUnlockBuilding(
        matchId: $checkedConvert('matchId', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$BuildingTypeEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnlockBuildingToJson(JsonUnlockBuilding instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'type': _$BuildingTypeEnumMap[instance.type]!,
    };

const _$BuildingTypeEnumMap = {
  BuildingType.none: 'none',
  BuildingType.barracks: 'barracks',
  BuildingType.factory: 'factory',
  BuildingType.airfield: 'airfield',
};
