// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonConfig _$JsonConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonConfig', json, ($checkedConvert) {
      final val = JsonConfig(
        resourcesPerPatch: $checkedConvert(
          'resourcesPerPatch',
          (v) => (v as num).toInt(),
        ),
        resourcesPerTurn: $checkedConvert(
          'resourcesPerTurn',
          (v) => (v as num).toInt(),
        ),
        popcap: $checkedConvert('popcap', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonConfigToJson(JsonConfig instance) =>
    <String, dynamic>{
      'resourcesPerPatch': instance.resourcesPerPatch,
      'resourcesPerTurn': instance.resourcesPerTurn,
      'popcap': instance.popcap,
    };
