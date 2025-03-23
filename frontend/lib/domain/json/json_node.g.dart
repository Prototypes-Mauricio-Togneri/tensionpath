// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNode _$JsonNodeFromJson(Map<String, dynamic> json) => JsonNode(
  x: (json['x'] as num).toInt(),
  y: (json['y'] as num).toInt(),
  type: $enumDecode(_$NodeTypeEnumMap, json['type']),
  player: json['player'] as String?,
);

const _$NodeTypeEnumMap = {
  NodeType.land: 'land',
  NodeType.launcher: 'launcher',
  NodeType.missile: 'missile',
};
