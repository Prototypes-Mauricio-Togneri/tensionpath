// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_platform_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlatformTemplate _$JsonPlatformTemplateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonPlatformTemplate', json, ($checkedConvert) {
  final val = JsonPlatformTemplate(
    id: $checkedConvert('id', (v) => v as String),
    pads: $checkedConvert(
      'pads',
      (v) => (v as List<dynamic>)
          .map((e) => JsonLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonPlatformTemplateToJson(
  JsonPlatformTemplate instance,
) => <String, dynamic>{
  'id': instance.id,
  'pads': instance.pads.map((e) => e.toJson()).toList(),
};
