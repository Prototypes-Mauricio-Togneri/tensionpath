// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_building_unlocked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventBuildingUnlocked _$JsonEventBuildingUnlockedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventBuildingUnlocked', json, ($checkedConvert) {
  final val = JsonEventBuildingUnlocked(
    playerIndex: $checkedConvert('playerIndex', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$BuildingTypeEnumMap, v)),
  );
  return val;
});

Map<String, dynamic> _$JsonEventBuildingUnlockedToJson(
  JsonEventBuildingUnlocked instance,
) => <String, dynamic>{
  'playerIndex': instance.playerIndex,
  'type': _$BuildingTypeEnumMap[instance.type]!,
};

const _$BuildingTypeEnumMap = {
  BuildingType.main: 'main',
  BuildingType.barracks: 'barracks',
  BuildingType.factory: 'factory',
  BuildingType.airfield: 'airfield',
};
