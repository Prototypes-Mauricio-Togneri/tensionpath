// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_battlefield.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBattlefield _$JsonBattlefieldFromJson(Map<String, dynamic> json) =>
    JsonBattlefield(
      id: json['id'] as String,
      size: JsonSize.fromJson(json['size'] as Map<String, dynamic>),
      gridRatio: JsonRatio.fromJson(json['gridRatio'] as Map<String, dynamic>),
      nodes:
          (json['nodes'] as List<dynamic>)
              .map((e) => JsonNode.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

JsonSize _$JsonSizeFromJson(Map<String, dynamic> json) => JsonSize(
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
);

JsonRatio _$JsonRatioFromJson(Map<String, dynamic> json) => JsonRatio(
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
);
