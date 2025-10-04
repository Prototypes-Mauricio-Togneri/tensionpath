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
    amount: $checkedConvert('amount', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$JsonResourceTemplateToJson(
  JsonResourceTemplate instance,
) => <String, dynamic>{
  'id': instance.id,
  'location': instance.location.toJson(),
  'amount': instance.amount,
};
