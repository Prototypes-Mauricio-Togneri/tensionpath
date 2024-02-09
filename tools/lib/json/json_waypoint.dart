import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/generators/base_generator.dart';
import 'package:tensionpath/json/json_node.dart';

part 'json_waypoint.g.dart';

@JsonSerializable()
class JsonWaypoint {
  final Vertex position;
  final JsonNode? node;

  const JsonWaypoint({
    required this.position,
    required this.node,
  });

  factory JsonWaypoint.fromJson(Map<String, dynamic> json) =>
      _$JsonWaypointFromJson(json);

  Map<String, dynamic> toJson() => _$JsonWaypointToJson(this);
}
