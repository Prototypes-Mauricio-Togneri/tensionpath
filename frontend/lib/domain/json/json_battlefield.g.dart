// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_battlefield.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBattlefield _$JsonBattlefieldFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonBattlefield', json, ($checkedConvert) {
      final val = JsonBattlefield(
        id: $checkedConvert('id', (v) => v as String),
        size: $checkedConvert(
          'size',
          (v) => JsonSize.fromJson(v as Map<String, dynamic>),
        ),
        gridRatio: $checkedConvert(
          'gridRatio',
          (v) => JsonRatio.fromJson(v as Map<String, dynamic>),
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
      'id': instance.id,
      'size': instance.size.toJson(),
      'gridRatio': instance.gridRatio.toJson(),
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };
