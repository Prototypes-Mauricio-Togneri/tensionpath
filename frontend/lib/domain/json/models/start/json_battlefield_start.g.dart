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
    maxHarvestersCount: $checkedConvert(
      'maxHarvestersCount',
      (v) => (v as num).toInt(),
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
    launchers: $checkedConvert(
      'launchers',
      (v) => (v as List<dynamic>)
          .map((e) => JsonLauncherStart.fromJson(e as Map<String, dynamic>))
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
  'maxHarvestersCount': instance.maxHarvestersCount,
  'missile': instance.missile.toJson(),
  'resources': instance.resources.map((e) => e.toJson()).toList(),
  'launchers': instance.launchers.map((e) => e.toJson()).toList(),
  'nodes': instance.nodes.map((e) => e.toJson()).toList(),
};
