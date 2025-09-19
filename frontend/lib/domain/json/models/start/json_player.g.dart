// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlayer _$JsonPlayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlayer', json, ($checkedConvert) {
      final val = JsonPlayer(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        isSelf: $checkedConvert('isSelf', (v) => v as bool),
        index: $checkedConvert('index', (v) => v as String),
        baseHealth: $checkedConvert('baseHealth', (v) => (v as num).toInt()),
        baseMaxHealth: $checkedConvert(
          'baseMaxHealth',
          (v) => (v as num).toInt(),
        ),
        resources: $checkedConvert('resources', (v) => (v as num).toDouble()),
        resourcesRateBase: $checkedConvert(
          'resourcesRateBase',
          (v) => (v as num).toDouble(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlayerToJson(JsonPlayer instance) =>
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
