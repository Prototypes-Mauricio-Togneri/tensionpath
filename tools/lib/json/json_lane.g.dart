// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_lane.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLane _$JsonLaneFromJson(Map<String, dynamic> json) => JsonLane(
      id: json['id'] as String,
      waypoints: (json['waypoints'] as List<dynamic>)
          .map((e) => JsonWaypoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonLaneToJson(JsonLane instance) => <String, dynamic>{
      'id': instance.id,
      'waypoints': instance.waypoints,
    };
