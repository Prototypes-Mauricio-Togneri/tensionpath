// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_waypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonWaypoint _$JsonWaypointFromJson(Map<String, dynamic> json) => JsonWaypoint(
      position:
          (json['position'] as List<dynamic>).map((e) => e as num).toList(),
      node: json['node'] == null
          ? null
          : JsonNode.fromJson(json['node'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonWaypointToJson(JsonWaypoint instance) =>
    <String, dynamic>{
      'position': instance.position,
      'node': instance.node,
    };
