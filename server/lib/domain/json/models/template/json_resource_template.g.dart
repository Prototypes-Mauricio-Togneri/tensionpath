// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_resource_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonResourceTemplate _$JsonResourceTemplateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonResourceTemplate', json, ($checkedConvert) {
  final val = JsonResourceTemplate(
    id: $checkedConvert('id', (v) => v as String),
    location: $checkedConvert(
      'location',
      (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
    ),
    amountCurrent: $checkedConvert('amountCurrent', (v) => v as num),
    amountMax: $checkedConvert('amountMax', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$JsonResourceTemplateToJson(
  JsonResourceTemplate instance,
) => <String, dynamic>{
  'id': instance.id,
  'location': instance.location.toJson(),
  'amountCurrent': instance.amountCurrent,
  'amountMax': instance.amountMax,
};
