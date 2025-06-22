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
        playerId: $checkedConvert('playerId', (v) => v as String?),
        platformId: $checkedConvert('platformId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JsonStructureToJson(JsonStructure instance) =>
    <String, dynamic>{
      'type': _$StructureTypeEnumMap[instance.type]!,
      if (instance.playerId case final value?) 'playerId': value,
      if (instance.platformId case final value?) 'platformId': value,
    };

const _$StructureTypeEnumMap = {
  StructureType.obstacle: 'obstacle',
  StructureType.resources: 'resources',
  StructureType.launcher: 'launcher',
  StructureType.missile: 'missile',
  StructureType.pad: 'pad',
};
