// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_battlefield_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBattlefieldStart _$JsonBattlefieldStartFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonBattlefieldStart', json, ($checkedConvert) {
  final val = JsonBattlefieldStart(
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
      (v) => JsonMissileStart.fromJson(v as Map<String, dynamic>),
    ),
    resources: $checkedConvert(
      'resources',
      (v) => (v as List<dynamic>)
          .map((e) => JsonResourceStart.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    buildings: $checkedConvert(
      'buildings',
      (v) => (v as List<dynamic>)
          .map((e) => JsonBuildingStart.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    nodes: $checkedConvert(
      'nodes',
      (v) => (v as List<dynamic>)
          .map((e) => JsonNodeStart.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonBattlefieldStartToJson(
  JsonBattlefieldStart instance,
) => <String, dynamic>{
  'mapSize': instance.mapSize.toJson(),
  'nodeSize': instance.nodeSize.toJson(),
  'missile': instance.missile.toJson(),
  'resources': instance.resources.map((e) => e.toJson()).toList(),
  'buildings': instance.buildings.map((e) => e.toJson()).toList(),
  'nodes': instance.nodes.map((e) => e.toJson()).toList(),
};
