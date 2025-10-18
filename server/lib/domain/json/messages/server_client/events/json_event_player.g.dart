// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventPlayer _$JsonEventPlayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonEventPlayer', json, ($checkedConvert) {
      final val = JsonEventPlayer(
        health: $checkedConvert('health', (v) => v as num),
        resources: $checkedConvert('resources', (v) => v as num),
        resourcesRate: $checkedConvert('resourcesRate', (v) => v as num),
        currentHarvesterCount: $checkedConvert(
          'currentHarvesterCount',
          (v) => (v as num).toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonEventPlayerToJson(JsonEventPlayer instance) =>
    <String, dynamic>{
      'health': instance.health,
      'resources': instance.resources,
      'resourcesRate': instance.resourcesRate,
      'currentHarvesterCount': instance.currentHarvesterCount,
    };
