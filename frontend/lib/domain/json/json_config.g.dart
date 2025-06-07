// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonConfig _$JsonConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonConfig', json, ($checkedConvert) {
      final val = JsonConfig(
        popcap: $checkedConvert('popcap', (v) => (v as num).toInt()),
        baseMaxHealth: $checkedConvert(
          'baseMaxHealth',
          (v) => (v as num).toInt(),
        ),
        resourcesPerPatch: $checkedConvert(
          'resourcesPerPatch',
          (v) => (v as num).toInt(),
        ),
        resourcesPerTurn: $checkedConvert(
          'resourcesPerTurn',
          (v) => (v as num).toInt(),
        ),
        resourcesPerSecond: $checkedConvert(
          'resourcesPerSecond',
          (v) => (v as num).toDouble(),
        ),
        defenseFactor: $checkedConvert(
          'defenseFactor',
          (v) => (v as num).toDouble(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonConfigToJson(JsonConfig instance) =>
    <String, dynamic>{
      'popcap': instance.popcap,
      'baseMaxHealth': instance.baseMaxHealth,
      'resourcesPerPatch': instance.resourcesPerPatch,
      'resourcesPerTurn': instance.resourcesPerTurn,
      'resourcesPerSecond': instance.resourcesPerSecond,
      'defenseFactor': instance.defenseFactor,
    };
