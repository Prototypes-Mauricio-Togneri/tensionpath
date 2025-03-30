// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_battlefield.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBattlefield _$JsonBattlefieldFromJson(Map<String, dynamic> json) =>
    JsonBattlefield(
      id: json['id'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      gridHeightRatio: (json['gridHeightRatio'] as num).toDouble(),
      nodes:
          (json['nodes'] as List<dynamic>)
              .map((e) => JsonNode.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
