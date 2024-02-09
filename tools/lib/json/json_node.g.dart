// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNode _$JsonNodeFromJson(Map<String, dynamic> json) => JsonNode(
      id: json['id'] as String,
      position:
          (json['position'] as List<dynamic>).map((e) => e as num).toList(),
    );

Map<String, dynamic> _$JsonNodeToJson(JsonNode instance) => <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
    };
