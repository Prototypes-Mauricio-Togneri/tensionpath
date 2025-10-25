// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventPlayer _$JsonEventPlayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonEventPlayer', json, ($checkedConvert) {
      final val = JsonEventPlayer(
        index: $checkedConvert('index', (v) => v as String),
        resources: $checkedConvert('resources', (v) => v as num),
        resourcesRate: $checkedConvert('resourcesRate', (v) => v as num),
        currentHarvesterCount: $checkedConvert(
          'currentHarvesterCount',
          (v) => (v as num).toInt(),
        ),
        maxHarvestersCount: $checkedConvert(
          'maxHarvestersCount',
          (v) => (v as num).toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonEventPlayerToJson(JsonEventPlayer instance) =>
    <String, dynamic>{
      'index': instance.index,
      'resources': instance.resources,
      'resourcesRate': instance.resourcesRate,
      'currentHarvesterCount': instance.currentHarvesterCount,
      'maxHarvestersCount': instance.maxHarvestersCount,
    };
