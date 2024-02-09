import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/json/json_waypoint.dart';

part 'json_lane.g.dart';

@JsonSerializable()
class JsonLane {
  final String id;
  final List<JsonWaypoint> waypoints;

  const JsonLane({
    required this.id,
    required this.waypoints,
  });

  factory JsonLane.fromJson(Map<String, dynamic> json) =>
      _$JsonLaneFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaneToJson(this);
}
