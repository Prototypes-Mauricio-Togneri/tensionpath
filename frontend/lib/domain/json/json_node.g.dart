// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNode _$JsonNodeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonNode', json, ($checkedConvert) {
      final val = JsonNode(
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
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
  'position': instance.position.toJson(),
  'structure': ?instance.structure?.toJson(),
};
