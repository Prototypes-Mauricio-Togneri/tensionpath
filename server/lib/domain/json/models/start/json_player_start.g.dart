// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_player_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlayerStart _$JsonPlayerStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlayerStart', json, ($checkedConvert) {
      final val = JsonPlayerStart(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        isSelf: $checkedConvert('isSelf', (v) => v as bool),
        index: $checkedConvert('index', (v) => v as String),
        baseHealth: $checkedConvert('baseHealth', (v) => v as num),
        baseMaxHealth: $checkedConvert('baseMaxHealth', (v) => v as num),
        resources: $checkedConvert('resources', (v) => v as num),
        resourcesRateBase: $checkedConvert(
          'resourcesRateBase',
          (v) => v as num,
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlayerStartToJson(JsonPlayerStart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelf': instance.isSelf,
      'index': instance.index,
      'baseHealth': instance.baseHealth,
      'baseMaxHealth': instance.baseMaxHealth,
      'resources': instance.resources,
      'resourcesRateBase': instance.resourcesRateBase,
    };
