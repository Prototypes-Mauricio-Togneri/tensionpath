// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_battlefield_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBattlefieldTemplate _$JsonBattlefieldTemplateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonBattlefieldTemplate', json, ($checkedConvert) {
  final val = JsonBattlefieldTemplate(
    mapSize: $checkedConvert(
      'mapSize',
      (v) => JsonSize.fromJson(v as Map<String, dynamic>),
    ),
    nodeSize: $checkedConvert(
      'nodeSize',
      (v) => JsonSize.fromJson(v as Map<String, dynamic>),
    ),
    platforms: $checkedConvert(
      'platforms',
      (v) => (v as List<dynamic>)
          .map((e) => JsonPlatformTemplate.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    nodes: $checkedConvert(
      'nodes',
      (v) => (v as List<dynamic>)
          .map((e) => JsonNodeTemplate.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonBattlefieldTemplateToJson(
  JsonBattlefieldTemplate instance,
) => <String, dynamic>{
  'mapSize': instance.mapSize.toJson(),
  'nodeSize': instance.nodeSize.toJson(),
  'platforms': instance.platforms.map((e) => e.toJson()).toList(),
  'nodes': instance.nodes.map((e) => e.toJson()).toList(),
};
