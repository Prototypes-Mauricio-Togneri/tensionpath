// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNode _$JsonNodeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonNode', json, ($checkedConvert) {
  final val = JsonNode(
    position: $checkedConvert(
      'position',
      (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
    ),
    resources: $checkedConvert(
      'resources',
      (v) =>
          v == null ? null : JsonResources.fromJson(v as Map<String, dynamic>),
    ),
    missile: $checkedConvert(
      'missile',
      (v) => v == null ? null : JsonMissile.fromJson(v as Map<String, dynamic>),
    ),
    pad: $checkedConvert(
      'pad',
      (v) => v == null ? null : JsonPad.fromJson(v as Map<String, dynamic>),
    ),
    launcher: $checkedConvert(
      'launcher',
      (v) =>
          v == null ? null : JsonLauncher.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonNodeToJson(JsonNode instance) => <String, dynamic>{
  'position': instance.position.toJson(),
  'resources': ?instance.resources?.toJson(),
  'missile': ?instance.missile?.toJson(),
  'pad': ?instance.pad?.toJson(),
  'launcher': ?instance.launcher?.toJson(),
};
