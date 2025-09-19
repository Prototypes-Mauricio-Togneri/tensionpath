// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNode _$JsonNodeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonNode', json, ($checkedConvert) {
      final val = JsonNode(
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$NodeTypeEnumMap, v) ?? NodeType.empty,
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonNodeToJson(JsonNode instance) => <String, dynamic>{
  'location': instance.location.toJson(),
  'type': _$NodeTypeEnumMap[instance.type]!,
};

const _$NodeTypeEnumMap = {
  NodeType.empty: 'empty',
  NodeType.resources: 'resources',
  NodeType.launcher: 'launcher',
  NodeType.pad: 'pad',
  NodeType.missile: 'missile',
};
