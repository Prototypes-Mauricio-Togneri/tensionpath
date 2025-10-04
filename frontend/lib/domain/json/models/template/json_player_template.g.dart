// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_player_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlayerTemplate _$JsonPlayerTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlayerTemplate', json, ($checkedConvert) {
      final val = JsonPlayerTemplate(
        index: $checkedConvert('index', (v) => v as String),
        baseHealth: $checkedConvert('baseHealth', (v) => v as num),
        resources: $checkedConvert('resources', (v) => v as num),
        resourcesRateBase: $checkedConvert(
          'resourcesRateBase',
          (v) => v as num,
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlayerTemplateToJson(JsonPlayerTemplate instance) =>
    <String, dynamic>{
      'index': instance.index,
      'baseHealth': instance.baseHealth,
      'resources': instance.resources,
      'resourcesRateBase': instance.resourcesRateBase,
    };
