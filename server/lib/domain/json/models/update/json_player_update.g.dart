// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_player_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlayerUpdate _$JsonPlayerUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlayerUpdate', json, ($checkedConvert) {
      final val = JsonPlayerUpdate(
        baseHealth: $checkedConvert('baseHealth', (v) => (v as num).toInt()),
        resources: $checkedConvert('resources', (v) => (v as num).toInt()),
        resourcesRate: $checkedConvert('resourcesRate', (v) => v as num),
        currentHarvesterCount: $checkedConvert(
          'currentHarvesterCount',
          (v) => (v as num).toInt(),
        ),
        maxHarvesterCount: $checkedConvert(
          'maxHarvesterCount',
          (v) => (v as num).toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonPlayerUpdateToJson(JsonPlayerUpdate instance) =>
    <String, dynamic>{
      'baseHealth': instance.baseHealth,
      'resources': instance.resources,
      'resourcesRate': instance.resourcesRate,
      'currentHarvesterCount': instance.currentHarvesterCount,
      'maxHarvesterCount': instance.maxHarvesterCount,
    };
