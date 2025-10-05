// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatchTemplate _$JsonMatchTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMatchTemplate', json, ($checkedConvert) {
      final val = JsonMatchTemplate(
        config: $checkedConvert(
          'config',
          (v) => JsonConfig.fromJson(v as Map<String, dynamic>),
        ),
        battlefield: $checkedConvert(
          'battlefield',
          (v) => JsonBattlefieldTemplate.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchTemplateToJson(JsonMatchTemplate instance) =>
    <String, dynamic>{
      'config': instance.config.toJson(),
      'battlefield': instance.battlefield.toJson(),
    };
