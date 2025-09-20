// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_node_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNodeTemplate _$JsonNodeTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonNodeTemplate', json, ($checkedConvert) {
      final val = JsonNodeTemplate(
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonNodeTemplateToJson(JsonNodeTemplate instance) =>
    <String, dynamic>{'location': instance.location.toJson()};
