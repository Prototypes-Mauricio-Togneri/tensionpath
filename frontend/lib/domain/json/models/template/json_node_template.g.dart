// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNodeTemplate _$JsonNodeTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonNodeTemplate', json, ($checkedConvert) {
      final val = JsonNodeTemplate(
        type: $checkedConvert('type', (v) => $enumDecode(_$NodeTypeEnumMap, v)),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonNodeTemplateToJson(JsonNodeTemplate instance) =>
    <String, dynamic>{
      'type': _$NodeTypeEnumMap[instance.type]!,
      'location': instance.location.toJson(),
    };

const _$NodeTypeEnumMap = {
  NodeType.empty: 'empty',
  NodeType.resources: 'resources',
  NodeType.launcher: 'launcher',
  NodeType.pad: 'pad',
  NodeType.water: 'water',
  NodeType.missile: 'missile',
};
