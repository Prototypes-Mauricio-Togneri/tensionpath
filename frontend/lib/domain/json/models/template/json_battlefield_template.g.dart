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
    missile: $checkedConvert(
      'missile',
      (v) => JsonMissileTemplate.fromJson(v as Map<String, dynamic>),
    ),
    resources: $checkedConvert(
      'resources',
      (v) => (v as List<dynamic>)
          .map((e) => JsonResourceTemplate.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    launchers: $checkedConvert(
      'launchers',
      (v) => (v as List<dynamic>)
          .map((e) => JsonLaunchersTemplate.fromJson(e as Map<String, dynamic>))
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
  'missile': instance.missile.toJson(),
  'resources': instance.resources.map((e) => e.toJson()).toList(),
  'launchers': instance.launchers.map((e) => e.toJson()).toList(),
  'nodes': instance.nodes.map((e) => e.toJson()).toList(),
};
