import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/generators/base_generator.dart';

part 'json_path.g.dart';

@JsonSerializable()
class JsonPath {
  final String name;
  final List<Vertex> vertices;

  const JsonPath({
    required this.name,
    required this.vertices,
  });

  factory JsonPath.fromJson(Map<String, dynamic> json) =>
      _$JsonPathFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPathToJson(this);
}
