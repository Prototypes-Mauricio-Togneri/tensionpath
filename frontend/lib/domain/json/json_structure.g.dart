// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_structure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonStructure _$JsonStructureFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonStructure', json, ($checkedConvert) {
      final val = JsonStructure(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$StructureTypeEnumMap, v),
        ),
        player: $checkedConvert('player', (v) => v as String?),
        platformId: $checkedConvert('platformId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JsonStructureToJson(JsonStructure instance) =>
    <String, dynamic>{
      'type': _$StructureTypeEnumMap[instance.type]!,
      'player': ?instance.player,
      'platformId': ?instance.platformId,
    };

const _$StructureTypeEnumMap = {
  StructureType.resources: 'resources',
  StructureType.launcher: 'launcher',
  StructureType.pad: 'pad',
};
