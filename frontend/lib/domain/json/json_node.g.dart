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
        structure: $checkedConvert(
          'structure',
          (v) => v == null
              ? null
              : JsonStructure.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonNodeToJson(JsonNode instance) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
  'structure': ?instance.structure?.toJson(),
};
