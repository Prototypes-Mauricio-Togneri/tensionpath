// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNode _$JsonNodeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonNode', json, ($checkedConvert) {
      final val = JsonNode(
        x: $checkedConvert('x', (v) => (v as num).toInt()),
        y: $checkedConvert('y', (v) => (v as num).toInt()),
        type: $checkedConvert('type', (v) => $enumDecode(_$NodeTypeEnumMap, v)),
        player: $checkedConvert('player', (v) => v as String?),
      );
      return val;
    });

const _$NodeTypeEnumMap = {
  NodeType.land: 'land',
  NodeType.resources: 'resources',
  NodeType.launcher: 'launcher',
  NodeType.missile: 'missile',
  NodeType.platform: 'platform',
};
