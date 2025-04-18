// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNode _$JsonNodeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonNode', json, ($checkedConvert) {
  final val = JsonNode(
    x: $checkedConvert('x', (v) => (v as num).toInt()),
    y: $checkedConvert('y', (v) => (v as num).toInt()),
    type: $checkedConvert('type', (v) => $enumDecode(_$NodeTypeEnumMap, v)),
    unit: $checkedConvert(
      'unit',
      (v) => v == null ? null : JsonUnit.fromJson(v as Map<String, dynamic>),
    ),
    structure: $checkedConvert(
      'structure',
      (v) =>
          v == null ? null : JsonStructure.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonNodeToJson(JsonNode instance) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
  'type': _$NodeTypeEnumMap[instance.type]!,
  if (instance.unit?.toJson() case final value?) 'unit': value,
  if (instance.structure?.toJson() case final value?) 'structure': value,
};

const _$NodeTypeEnumMap = {
  NodeType.land: 'land',
  NodeType.water: 'water',
  NodeType.rock: 'rock',
};
