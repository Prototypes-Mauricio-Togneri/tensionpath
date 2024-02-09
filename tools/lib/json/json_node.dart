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

  bool closeTo(Vertex vertex) {
    final num diffX = (position[0] - vertex[0]).abs();
    final num diffY = (position[1] - vertex[1]).abs();

    return (diffX < 0.1) && (diffY < 0.1);
  }

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
