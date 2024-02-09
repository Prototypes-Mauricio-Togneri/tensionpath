import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/generators/base_generator.dart';

part 'json_node.g.dart';

@JsonSerializable()
class JsonNode {
  final String id;
  final Vertex position;

  const JsonNode({
    required this.id,
    required this.position,
  });

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
