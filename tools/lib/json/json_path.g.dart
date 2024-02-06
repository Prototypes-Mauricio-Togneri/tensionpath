// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPath _$JsonPathFromJson(Map<String, dynamic> json) => JsonPath(
      name: json['name'] as String,
      vertices: (json['vertices'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as num).toList())
          .toList(),
    );

Map<String, dynamic> _$JsonPathToJson(JsonPath instance) => <String, dynamic>{
      'name': instance.name,
      'vertices': instance.vertices,
    };
