// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_lane.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLane _$JsonLaneFromJson(Map<String, dynamic> json) => JsonLane(
      name: json['name'] as String,
      vertices: (json['vertices'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as num).toList())
          .toList(),
    );

Map<String, dynamic> _$JsonLaneToJson(JsonLane instance) => <String, dynamic>{
      'name': instance.name,
      'vertices': instance.vertices,
    };
