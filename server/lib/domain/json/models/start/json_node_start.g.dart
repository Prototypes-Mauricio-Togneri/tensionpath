// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNodeStart _$JsonNodeStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonNodeStart', json, ($checkedConvert) {
      final val = JsonNodeStart(
        type: $checkedConvert('type', (v) => $enumDecode(_$NodeTypeEnumMap, v)),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        playerIndex: $checkedConvert('playerIndex', (v) => v as String?),
        platformId: $checkedConvert('platformId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JsonNodeStartToJson(JsonNodeStart instance) =>
    <String, dynamic>{
      'type': _$NodeTypeEnumMap[instance.type]!,
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
      'playerIndex': ?instance.playerIndex,
      'platformId': ?instance.platformId,
    };

const _$NodeTypeEnumMap = {
  NodeType.empty: 'empty',
  NodeType.resources: 'resources',
  NodeType.launcher: 'launcher',
  NodeType.pad: 'pad',
  NodeType.rocks_low: 'rocks_low',
  NodeType.missile: 'missile',
};
