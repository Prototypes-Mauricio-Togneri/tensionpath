// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNodeStart _$JsonNodeStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonNodeStart', json, ($checkedConvert) {
      final val = JsonNodeStart(
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        type: $checkedConvert('type', (v) => $enumDecode(_$NodeTypeEnumMap, v)),
      );
      return val;
    });

Map<String, dynamic> _$JsonNodeStartToJson(JsonNodeStart instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
      'type': _$NodeTypeEnumMap[instance.type]!,
    };

const _$NodeTypeEnumMap = {
  NodeType.empty: 'empty',
  NodeType.resources: 'resources',
  NodeType.launcher: 'launcher',
  NodeType.pad: 'pad',
  NodeType.missile: 'missile',
};
