// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNodeTemplate _$JsonNodeTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonNodeTemplate', json, ($checkedConvert) {
      final val = JsonNodeTemplate(
        type: $checkedConvert('type', (v) => $enumDecode(_$NodeTypeEnumMap, v)),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        playerIndex: $checkedConvert('playerIndex', (v) => v as String?),
        platformId: $checkedConvert('platformId', (v) => v as String?),
        building: $checkedConvert(
          'building',
          (v) => $enumDecodeNullable(_$BuildingTypeEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonNodeTemplateToJson(JsonNodeTemplate instance) =>
    <String, dynamic>{
      'type': _$NodeTypeEnumMap[instance.type]!,
      'location': instance.location.toJson(),
      'playerIndex': ?instance.playerIndex,
      'platformId': ?instance.platformId,
      'building': ?_$BuildingTypeEnumMap[instance.building],
    };

const _$NodeTypeEnumMap = {
  NodeType.empty: 'empty',
  NodeType.resources: 'resources',
  NodeType.building: 'building',
  NodeType.pad: 'pad',
  NodeType.rocks_low: 'rocks_low',
  NodeType.missile: 'missile',
};

const _$BuildingTypeEnumMap = {
  BuildingType.main: 'main',
  BuildingType.barracks: 'barracks',
  BuildingType.factory: 'factory',
  BuildingType.airfield: 'airfield',
  BuildingType.tech: 'tech',
};
