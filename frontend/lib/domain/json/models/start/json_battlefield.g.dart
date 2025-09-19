// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_battlefield.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBattlefield _$JsonBattlefieldFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonBattlefield', json, ($checkedConvert) {
      final val = JsonBattlefield(
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
          (v) => JsonMissile.fromJson(v as Map<String, dynamic>),
        ),
        resources: $checkedConvert(
          'resources',
          (v) => (v as List<dynamic>)
              .map((e) => JsonResource.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        launchers: $checkedConvert(
          'launchers',
          (v) => (v as List<dynamic>)
              .map((e) => JsonLaunchers.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nodes: $checkedConvert(
          'nodes',
          (v) => (v as List<dynamic>)
              .map((e) => JsonNode.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonBattlefieldToJson(JsonBattlefield instance) =>
    <String, dynamic>{
      'mapSize': instance.mapSize.toJson(),
      'nodeSize': instance.nodeSize.toJson(),
      'missile': instance.missile.toJson(),
      'resources': instance.resources.map((e) => e.toJson()).toList(),
      'launchers': instance.launchers.map((e) => e.toJson()).toList(),
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };
