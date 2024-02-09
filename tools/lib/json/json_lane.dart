import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/generators/base_generator.dart';

part 'json_lane.g.dart';

@JsonSerializable()
class JsonLane {
  final String name;
  final List<Vertex> vertices;

  const JsonLane({
    required this.name,
    required this.vertices,
  });

  factory JsonLane.fromJson(Map<String, dynamic> json) =>
      _$JsonLaneFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaneToJson(this);
}
